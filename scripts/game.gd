extends Node3D

signal update_hud
signal spawn_acorn
signal toggle_player_camera(is_on: bool)


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if GAME.started:
		if Input.is_action_just_pressed("ui_cancel"):
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
		GAME.inventory[1] -= 1
		update_hud.emit()
		
		spawn_acorn.emit()


func _on_home_deposit_acorn() -> void:
	GAME.deposit[GAME.DEPOSIT_TYPE.ACORN] += 1
	update_hud.emit()


func _on_home_progress_day() -> void:
	await Fade.fade_out().finished
	
	GAME.state["day"] += 1
	GAME.deposit[GAME.DEPOSIT_TYPE.LOG] += GAME.inventory[GAME.PICKABLE_TYPE.LOG]
	GAME.reset_inventory()
	
	%DayTimer.start()
	%SpawnTimer.start()
	Fade.fade_in()


func _on_player_player_died() -> void:
	%DayTimer.paused = true
	%SpawnTimer.paused = true


func _on_hud_restart_game() -> void:
	await Fade.fade_out().finished
	
	get_tree().paused = false
	GAME.reset_everything()
	GAME.started = false
	%MMCamera.current = true
	toggle_player_camera.emit(false)
	
	get_tree().reload_current_scene()
	Fade.fade_in()


func _on_main_menu_start_game() -> void:
	await Fade.fade_out().finished
	
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
