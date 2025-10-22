extends Node3D


func _ready() -> void:
	%TreeDeadLarge.visible = false
	
	match randi_range(0, get_child_count() - 1):
		0:
			%TreeDeadLarge.visible = true
			%TdlCS.disabled = false
		1:
			%TreeDeadLargeDecorated.visible = true
			%TdldCS.disabled = false
		2:
			%TreeDeadMedium.visible = true
			%TdmCS.disabled = false
		3:
			%TreePineOrangeLarge.visible = true
			%TpolCS.disabled = false
		4:
			%TreePineOrangeMedium.visible = true
			%TpomCS.disabled = false
		5:
			%TreePineYellowLarge.visible = true
			%TpylCS.disabled = false
		6:
			%TreePineYellowMedium.visible = true
			%TpymCS.disabled = false
