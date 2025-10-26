extends Node3D

@export var min_pickable := 3


func randomize_positions() -> void:
	var pickables := get_children()
	var max_pickable := pickables.size()
	
	for p in pickables:
		p.visible = false
		p.process_mode = Node.PROCESS_MODE_DISABLED
	
	for i in range(randi_range(min_pickable, max_pickable)):
		var random_pickable = randi_range(0, max_pickable - 1)
		
		if pickables[random_pickable].visible:
			while pickables[random_pickable].visible:
				random_pickable = randi_range(0, max_pickable - 1)
		
		pickables[random_pickable].visible = true
		pickables[random_pickable].process_mode = Node.PROCESS_MODE_INHERIT


func _ready() -> void:
	randomize_positions()


func _on_game_update_positions() -> void:
	randomize_positions()
