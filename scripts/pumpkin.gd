extends Node3D

var is_a_pumpkin := true


func _ready() -> void:
	%PumpkinOrange.visible = false
	rotation.x = randf_range(0, 2)
	rotation.z = randf_range(0, 2)
	
	var pumpkin: RigidBody3D
	
	for child in get_children():
		child.process_mode = Node.PROCESS_MODE_DISABLED
	
	match randi_range(0, get_child_count() - 1):
		0:
			%PumpkinOrange.visible = true
			%PoCS.disabled = false
			pumpkin = %PumpkinOrange
		1:
			%PumpkinOrangeJackolantern.visible = true
			%PojCS.disabled = false
			pumpkin = %PumpkinOrangeJackolantern
		2:
			%PumpkinOrangeSmall.visible = true
			%PosCS.disabled = false
			pumpkin = %PumpkinOrangeSmall
		3:
			%PumpkinYellow.visible = true
			%PyCS.disabled = false
			pumpkin = %PumpkinYellow
		4:
			%PumpkinYellowJackolantern.visible = true
			%PyjCS.disabled = false
			pumpkin = %PumpkinYellowJackolantern
		5:
			%PumpkinYellowSmall.visible = true
			%PysCS.disabled = false
			pumpkin = %PumpkinYellowSmall
			
	var random_dir = Vector3(
		randf_range(-1.0, 1.0),
		0,
		randf_range(-1.0, 1.0)
	).normalized()
	
	pumpkin.process_mode = Node.PROCESS_MODE_INHERIT
	pumpkin.apply_central_impulse(random_dir * randf_range(1.0, 3.0))
	pumpkin.apply_torque_impulse(Vector3(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	) * randf_range(0.2, 1.0))
