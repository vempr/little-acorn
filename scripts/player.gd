extends RigidBody3D

signal trigger_shop
signal update_hud

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var move_force := 2000.0
var can_open_shop := false


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
	
	var player_rotation = %TwistPivot.rotation.y + PI
	%SquirrelMesh.rotation.y = player_rotation
	%PickableCast.rotation.y = player_rotation
	
	%TwistPivot.rotate_y(twist_input)
	%PitchPivot.rotate_x(pitch_input)
	%PitchPivot.rotation.x = clamp(
		%PitchPivot.rotation.x,
		deg_to_rad(-50),
		deg_to_rad(10)
	)
	
	twist_input = 0.0
	pitch_input = 0.0
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if can_open_shop:
		if Input.is_action_just_pressed("toggle_shop"):
			trigger_shop.emit()
	
	if %PickableCast.is_colliding():
		var collider = %PickableCast.get_collider()
		if collider:
			var mesh = collider.get_parent()
			var node_scene_instance = mesh.get_parent()
			
			if "pickable_type" in node_scene_instance:
				if Input.is_action_just_pressed("pick_up"):
					GAME.inventory[node_scene_instance.pickable_type] += 1
					node_scene_instance.queue_free()
					update_hud.emit()
					return
			
			var node = node_scene_instance.get_parent()
			if "pickable_type" in node:
				if Input.is_action_just_pressed("pick_up"):
					GAME.inventory[node.pickable_type] += 1
					node.queue_free()
					update_hud.emit()
	


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity


func _on_shop_update_shop_visibility(isVisible: bool) -> void:
	can_open_shop = isVisible
