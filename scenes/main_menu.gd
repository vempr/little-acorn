extends Node3D

signal start_game


func _process(delta: float) -> void:
	%MMCamera.rotation.y += deg_to_rad(delta)


func _on_play_button_pressed() -> void:
	start_game.emit()
