extends Node3D

var pickable_type := GAME.PICKABLE_TYPE.CANDY

func _ready() -> void:
	rotation.y = randf_range(0.0, 2.0)
