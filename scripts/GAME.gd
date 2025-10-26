extends Node

enum PICKABLE_TYPE { LOG, CANDY }
enum DRAGGABLE_TYPE { ACORN }
enum DEPOSIT_TYPE { LOG, ACORN }

var state := {
	"day": 1
}

var inventory := {
	PICKABLE_TYPE.LOG: 0,
	PICKABLE_TYPE.CANDY: 0,
}

var deposit := {
	DEPOSIT_TYPE.LOG: 0,
	DEPOSIT_TYPE.ACORN: 0,
}


func reset_inventory() -> void:
	inventory = {
		PICKABLE_TYPE.LOG: 0,
		PICKABLE_TYPE.CANDY: 0,
	}


func reset_everything() -> void:
	reset_inventory()
	deposit = {
		DEPOSIT_TYPE.LOG: 0,
		DEPOSIT_TYPE.ACORN: 0,
	}
	state = {
		"day": 1
	}
