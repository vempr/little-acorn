extends Node3D

signal update_shop_visibility(isVisible: bool)

@onready var AcornScene := preload("res://scenes/pickable/acorn.tscn")


func _on_buy_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		update_shop_visibility.emit(true)


func _on_buy_area_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		update_shop_visibility.emit(false)


func _on_game_spawn_acorn() -> void:
	%AcornPathFollow.progress_ratio = randf()
	var acorn = AcornScene.instantiate()
	acorn.global_position = %AcornPathFollow.global_position
	get_parent().add_child(acorn)
