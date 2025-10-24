extends CanvasLayer


func _on_shop_update_shop_visibility(isVisible: bool) -> void:
	$OpenShopLabel.visible = isVisible


func update_hud() -> void:
	var t := "Logs: " + str(GAME.inventory[0]) + "\n"
	t += "Candy: " + str(GAME.inventory[1])
	$Label.text = t


func _on_player_update_hud() -> void:
	update_hud()


func _on_game_update_hud() -> void:
	update_hud()
