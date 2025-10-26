extends CanvasLayer

signal exit_to_main_menu


func _unhandled_input(_event: InputEvent) -> void:
	if GAME.started:
		if Input.is_action_pressed("pause_game"):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				get_tree().paused = true
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				%HUD.visible = false
				visible = true
			else:
				get_tree().paused = false
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				visible = false
				%HUD.visible = true


func _on_main_menu_button_pressed() -> void:
	exit_to_main_menu.emit()


func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	visible = false
	%HUD.visible = true
