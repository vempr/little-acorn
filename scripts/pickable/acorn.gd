extends RigidBody3D

var draggable_type := GAME.DRAGGABLE_TYPE.ACORN
var is_being_held := false


func _ready() -> void:
	rotation.x = randf_range(0, 2)
	rotation.z = randf_range(0, 2)


func _physics_process(_delta: float) -> void:
	if !is_being_held:
		%CollisionShape.disabled = false
		apply_central_force(Vector3(0, -9.8, 0))
	else:
		%CollisionShape.disabled = true
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
