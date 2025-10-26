extends Node3D


func _ready() -> void:
	for child in get_children():
		child.rotation.y = randi_range(1, 4) * deg_to_rad(90)
