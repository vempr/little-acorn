extends Node3D


func _ready() -> void:
	if randi_range(0, 1) == 0:
		%BenchBasic.visible = true
	else:
		%BenchDecorated.visible = true
