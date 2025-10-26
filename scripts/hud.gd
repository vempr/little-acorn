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
	%DayLabel.text = "day " + str(GAME.state["day"]) + "/5"
	%BranchStat.text = str(GAME.inventory[GAME.PICKABLE_TYPE.LOG])
	%CandyStat.text = str(GAME.inventory[GAME.PICKABLE_TYPE.CANDY])
	%TimeLabel.text = "%.2fs" % %DayTimer.time_left
	
	%DepositBranch.text = str(GAME.deposit[GAME.DEPOSIT_TYPE.LOG]) + " (30 needed)"
	%DepositAcorn.text = str(GAME.deposit[GAME.DEPOSIT_TYPE.ACORN]) + " (15 needed)"


func _on_player_update_hud() -> void:
	update_hud()


func _on_game_update_hud() -> void:
	update_hud()


func _on_home_update_home_visibility(isVisible: bool) -> void:
	var tween = create_tween()
	
	if isVisible:
		tween.tween_property($HomeLabel, "modulate:a", 1.0, 0.2)
		%Deposit.visible = true
	else:
		tween.tween_property($HomeLabel, "modulate:a", 0.0, 0.2)
		%Deposit.visible = false


func _on_player_player_died() -> void:
	$HomeLabel.visible = false
	$OpenShopLabel.visible = false
	%Deposit.visible = false
	%Stats.visible = false
	%Dead.visible = true


func _on_restart_button_pressed() -> void:
	restart_game.emit()
