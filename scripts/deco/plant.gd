extends Node3D


func _ready() -> void:
	rotation.y = randf_range(0, 2)
	$Plant_1.visible = false
	var i := randi_range(1, 6)
	
	get_node("Plant_" + str(i)).visible = true
