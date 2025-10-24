extends Node3D

signal deposit_acorn
signal update_home_visibility(isVisible: bool)
signal progress_day

var at_home := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("sleep") && at_home:
		progress_day.emit()


func _on_home_area_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		at_home = true
		update_home_visibility.emit(at_home)
	
	if "draggable_type" in body:
		body.queue_free()
		deposit_acorn.emit()


func _on_home_area_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		at_home = false
		update_home_visibility.emit(at_home)
