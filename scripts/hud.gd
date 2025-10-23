extends CanvasLayer


func _on_shop_update_shop_visibility(isVisible: bool) -> void:
	$OpenShopLabel.visible = isVisible
	if !$OpenShopLabel.visible:
		$Shop.visible = false


func _on_player_trigger_shop() -> void:
	$Shop.visible = !$Shop.visible


func _on_player_update_hud() -> void:
	var t := "Logs: " + str(GAME.inventory[0]) + "\n"
	t += "Candy: " + str(GAME.inventory[1])
	$Label.text = t
