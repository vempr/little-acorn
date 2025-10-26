extends Path3D

@onready var path := %PumpkinPathFollow
@onready var PumpkinScene := preload("res://scenes/pumpkin.tscn")


func _on_spawn_timer_timeout() -> void:
	path.progress_ratio = randf()
	var pumpkin := PumpkinScene.instantiate()
	pumpkin.position = path.position
	
	add_child(pumpkin)
	%SpawnTimer.start(randf_range(0.5, 1))


func _on_game_update_positions() -> void:
	for child in get_children():
		if "is_a_pumpkin" in child:
			child.queue_free()
