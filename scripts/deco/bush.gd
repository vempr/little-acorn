extends Node3D


func _ready() -> void:
	rotation.y = randf_range(0, 2)
	$Bush_1.visible = false
	var i := randi_range(1, 3)
	
	get_node("Bush_" + str(i)).visible = true
