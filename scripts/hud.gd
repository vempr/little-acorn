extends CanvasLayer

signal restart_game


func _ready() -> void:
	$OpenShopLabel.modulate.a = 0.0
	$HomeLabel.modulate.a = 0.0
	update_hud()


func _process(_delta) -> void:
	update_hud()


func _on_shop_update_shop_visibility(isVisible: bool) -> void:
	var tween = create_tween()
	
	if isVisible:
		tween.tween_property($OpenShopLabel, "modulate:a", 1.0, 0.2)
	else:
		tween.tween_property($OpenShopLabel, "modulate:a", 0.0, 0.2)


func update_hud() -> void:
	var t := "Day: " + str(GAME.state["day"]) + "\n"
	t += "Logs: " + str(GAME.inventory[0]) + "\n"
	t += "Candy: " + str(GAME.inventory[1]) + "\n"
	t += "Deposited acorns: "  + str(GAME.deposit[GAME.DEPOSIT_TYPE.ACORN]) + "\n"
	t += "Deposited logs: "  + str(GAME.deposit[GAME.DEPOSIT_TYPE.LOG]) + "\n"
	t += "Time left: %.2f\n" % %DayTimer.time_left
	$Label.text = t


func _on_player_update_hud() -> void:
	update_hud()


func _on_game_update_hud() -> void:
	update_hud()


func _on_home_update_home_visibility(isVisible: bool) -> void:
	var tween = create_tween()
	
	if isVisible:
		tween.tween_property($HomeLabel, "modulate:a", 1.0, 0.2)
	else:
		tween.tween_property($HomeLabel, "modulate:a", 0.0, 0.2)


func _on_player_player_died() -> void:
	$Label.visible = false
	$OpenShopLabel.visible = false
	$HomeLabel.visible = false
	
	%DieLabel.visible = true
	%RestartButton.visible = true
	%MainMenuButton.visible = true
	pass # Replace with function body.


func _on_restart_button_pressed() -> void:
	restart_game.emit()
