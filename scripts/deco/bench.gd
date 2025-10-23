extends Node3D


func _ready() -> void:
	%BenchPreview.visible = false
	
	if randi_range(0, 1) == 0:
		%BenchBasic.visible = true
	else:
		%BenchDecorated.visible = true
