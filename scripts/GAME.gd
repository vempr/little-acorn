extends Node

enum PICKABLE_TYPE { LOG, CANDY }
enum DRAGGABLE_TYPE { ACORN }

var inventory := {
	PICKABLE_TYPE.LOG: 0,
	PICKABLE_TYPE.CANDY: 0,
}
