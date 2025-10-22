extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var jump_force := 8.0
var is_grounded := false


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	var input = Vector3.ZERO
	input.x = Input.get_axis("left", "right")
	input.z = Input.get_axis("forward", "backward")
	
	apply_central_force(%TwistPivot.basis * input * delta * 1200.0)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	is_grounded = %GroundRay.is_colliding()

	if Input.is_action_just_pressed("jump") and is_grounded:
		apply_central_impulse(Vector3.UP * jump_force)
	
	%TwistPivot.rotate_y(twist_input)
	%PitchPivot.rotate_x(pitch_input)
	%PitchPivot.rotation.x = clamp(
		%PitchPivot.rotation.x,
		deg_to_rad(-30),
		deg_to_rad(30)
	)
	
	twist_input = 0.0
	pitch_input = 0.0


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
