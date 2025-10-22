extends Node3D


func _ready() -> void:
	%PumpkinOrange.visible = false
	
	match randi_range(0, get_child_count() - 1):
		0:
			%PumpkinOrange.visible = true
			%PoCS.disabled = false
		1:
			%PumpkinOrangeJackolantern.visible = true
			%PojCS.disabled = false
		2:
			%PumpkinOrangeSmall.visible = true
			%PosCS.disabled = false
		3:
			%PumpkinYellow.visible = true
			%PyCS.disabled = false
		4:
			%PumpkinYellowJackolantern.visible = true
			%PyjCS.disabled = false
		5:
			%PumpkinYellowSmall.visible = true
			%PysCS.disabled = false
