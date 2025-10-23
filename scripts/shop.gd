extends Node3D

signal update_shop_visibility(isVisible: bool)


func _on_buy_area_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		update_shop_visibility.emit(true)


func _on_buy_area_body_exited(body: Node3D) -> void:
	if body is RigidBody3D:
		update_shop_visibility.emit(false)
