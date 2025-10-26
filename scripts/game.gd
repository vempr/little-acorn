extends Node3D

signal update_hud
signal update_positions
signal spawn_acorn
signal toggle_player_camera(is_on: bool)


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if GAME.started:
		if Input.is_action_just_pressed("pause_game"):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				get_tree().paused = true
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:
				get_tree().paused = false
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
		%WorldEnvironment.environment.background_energy_multiplier = 1.0 + (%DayTimer.time_left - 60.0) * 0.013
		%Light.light_energy = 1.0 + (%DayTimer.time_left - 60.0) * 0.015


func _on_player_buy_acorn() -> void:
	if GAME.inventory[1] > 0:
		%BuyAcorn.play()
		GAME.inventory[1] -= 1
		update_hud.emit()
		
		spawn_acorn.emit()


func _on_home_deposit_acorn() -> void:
	%AcornDeposit.play()
	GAME.deposit[GAME.DEPOSIT_TYPE.ACORN] += 1
	update_hud.emit()


func _on_home_progress_day() -> void:
	%Sleep.play()
	await Fade.fade_out().finished
	update_positions.emit()
	
	GAME.state["day"] += 1
	GAME.deposit[GAME.DEPOSIT_TYPE.LOG] += GAME.inventory[GAME.PICKABLE_TYPE.LOG]
	if GAME.state["day"] == 6:
		%DayTimer.stop()
		%SpawnTimer.stop()
		end_game()
		return
	else:
		GAME.reset_inventory()
		
		%DayTimer.start()
		%SpawnTimer.start()
		Fade.fade_in()


func _on_player_player_died() -> void:
	%DayTimer.paused = true
	%SpawnTimer.paused = true


func _on_hud_restart_game() -> void:
	await Fade.fade_out().finished
	
	%Light.visible = true
	%Win.visible = false
	%Lose.visible = false
	%WinCanvas.visible = false
	%LoseCanvas.visible = false
	%StatCanvas.visible = false
	%EndCamera.current = false
	
	get_tree().paused = false
	GAME.reset_everything()
	GAME.started = false
	%MMCamera.current = true
	toggle_player_camera.emit(false)
	
	get_tree().reload_current_scene()
	Fade.fade_in()


func _on_main_menu_start_game() -> void:
	await Fade.fade_out().finished
	
	%Light.visible = true
	%MMCamera.current = false
	toggle_player_camera.emit(true)
	%MainMenu.visible = false
	%MMCanvas.visible = false
	%Player.visible = true
	
	Fade.fade_in()
	GAME.started = true
	%HUD.visible = true
	%DayTimer.start()
	%SpawnTimer.start()


func _on_pause_menu_exit_to_main_menu() -> void:
	_on_hud_restart_game()


func _on_day_timer_timeout() -> void:
	%Sleep.play()
	await Fade.fade_out().finished
	update_positions.emit()
	
	GAME.state["day"] += 1
	if GAME.state["day"] == 6:
		%DayTimer.stop()
		%SpawnTimer.stop()
		%Player.day_is_over = false
		end_game()
		return
	else:
		GAME.reset_inventory()
		
		%DayTimer.start()
		%SpawnTimer.start()
		%Player.day_is_over = false
		Fade.fade_in()


func end_game() -> void:
	toggle_player_camera.emit(false)
	%HUD.visible = false
	%Player.visible = false
	%EndCamera.current = true
	%Light.visible = false
	%StatCanvas.visible = true
	
	if GAME.deposit[GAME.DEPOSIT_TYPE.LOG] >= 30 && GAME.deposit[GAME.DEPOSIT_TYPE.ACORN] >= 15:
		%Win.visible = true
		%WinCanvas.visible = true
	else:
		%Lose.visible = true
		%LoseCanvas.visible = true
	
	%ESDepositBranch.text = str(GAME.deposit[GAME.DEPOSIT_TYPE.LOG]) + " (30 needed)"
	%ESDepositAcorn.text = str(GAME.deposit[GAME.DEPOSIT_TYPE.ACORN]) + " (15 needed)"
	
	Fade.fade_in()
