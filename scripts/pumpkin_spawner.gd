extends Path3D

@onready var path := %PumpkinPathFollow
@onready var PumpkinScene := preload("res://scenes/pumpkin.tscn")


func _on_spawn_timer_timeout() -> void:
	path.progress_ratio = randf()
	var pumpkin := PumpkinScene.instantiate()
	pumpkin.position = path.position
	
	add_child(pumpkin)
	%SpawnTimer.start(randf_range(1, 2))
