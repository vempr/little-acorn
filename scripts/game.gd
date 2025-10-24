extends Node3D

signal update_hud
signal spawn_acorn


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _on_player_buy_acorn() -> void:
	if GAME.inventory[1] > 0:
		GAME.inventory[1] -= 1
		update_hud.emit()
		
		spawn_acorn.emit()
