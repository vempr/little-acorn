extends RigidBody3D

signal buy_acorn
signal update_hud
signal player_died

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var move_force := 4000.0
var can_open_shop := false
var is_holding_acorn := false
var acorn


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
	
	if can_open_shop:
		if Input.is_action_just_pressed("toggle_shop"):
			buy_acorn.emit()
	
	if is_holding_acorn:
		if Input.is_action_just_pressed("pick_up"):
			is_holding_acorn = false
			acorn.is_being_held = false
			acorn = null
			return

		acorn.position = position + Vector3(0, 1.5, 0)
	
	if %PickableCast.is_colliding():
		var collider = %PickableCast.get_collider()
		
		if "draggable_type" in collider:
			if Input.is_action_just_pressed("pick_up"):
				is_holding_acorn = true
				acorn = collider
				acorn.is_being_held = true
				return
		
		if collider:
			var mesh = collider.get_parent()
			
			if mesh.name == "Game":
				return
				
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
	


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity


func _on_shop_update_shop_visibility(isVisible: bool) -> void:
	can_open_shop = isVisible


func _on_pumpkin_area_body_entered(body: Node3D) -> void:
	if "is_a_pumpkin" in body.get_parent():
		for child in get_children():
			child.visible = false
		%Skull.visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		call_deferred("stop")


func stop() -> void:
	player_died.emit()
	process_mode = Node.PROCESS_MODE_DISABLED


func _on_game_toggle_player_camera() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	%Camera.current = true
