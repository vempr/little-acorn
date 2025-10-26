extends Node3D

signal update_hud
signal spawn_acorn


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
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
	
	get_tree().reload_current_scene()
	Fade.fade_in()


func _on_player_player_died() -> void:
	%DayTimer.paused = true
	%SpawnTimer.paused = true


func _on_hud_restart_game() -> void:
	await Fade.fade_out().finished
	GAME.reset_everything()
	get_tree().reload_current_scene()
	Fade.fade_in()
