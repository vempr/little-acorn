extends Node3D

@onready var l1 = preload("res://scenes/pickable/log_types/log_1.tscn")
@onready var l2 = preload("res://scenes/pickable/log_types/log_2.tscn")
var pickable_type := GAME.PICKABLE_TYPE.LOG


func _ready() -> void:
	%PreviewMesh.visible = false
	rotation.y = randf_range(0.0, 2.0)
	
	if randi_range(0, 1) == 0:
		add_child(l1.instantiate())
	else:
		add_child(l2.instantiate())
