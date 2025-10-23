extends RigidBody3D

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var move_force := 2000.0


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(delta: float) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var input = Vector3.ZERO
		input.x = Input.get_axis("left", "right")
		input.z = Input.get_axis("forward", "backward")
		
		if input.length() > 0:
			input = input.normalized()
		apply_central_force(%TwistPivot.basis * input * move_force * delta)
	
	# JUMPING IS SCRAPPED:
	# when RigidBody3D jumps and collides with body while holding,
	# RigidBody3D won't fall. the workarounds are not reliable
	# and my hardware doesn't allow me to use CharacterBody3D
	# [it is much heavier, i get like ~1FPS :(]
	# is_grounded = %GroundRay.is_colliding()
	# if Input.is_action_just_pressed("jump") and is_grounded:
		# apply_central_impulse(Vector3.UP * jump_force)
	
	%SquirrelMesh.rotation.y = %TwistPivot.rotation.y + PI
	%TwistPivot.rotate_y(twist_input)
	%PitchPivot.rotate_x(pitch_input)
	%PitchPivot.rotation.x = clamp(
		%PitchPivot.rotation.x,
		deg_to_rad(-50),
		deg_to_rad(30)
	)
	
	twist_input = 0.0
	pitch_input = 0.0
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
