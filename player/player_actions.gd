extends Node

signal moved_clockwise
signal moved_counter_clockwise

@export var spin_animation_time: float = 0.5

enum Actions {NONE, MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT}

var player: Player

var up: Actions = Actions.MOVE_UP
var down: Actions = Actions.MOVE_DOWN
var left: Actions = Actions.MOVE_LEFT
var right: Actions = Actions.MOVE_RIGHT


func do_action(direction: Player.FacingDirections) -> void:
	match direction:
		Player.FacingDirections.UP:
			_run_action(up)
		Player.FacingDirections.DOWN:
			_run_action(down)
		Player.FacingDirections.LEFT:
			_run_action(left)
		Player.FacingDirections.RIGHT:
			_run_action(right)


func _run_action(action: Actions) -> void:
	match action:
		Actions.MOVE_UP:
			player.move_up()
		Actions.MOVE_DOWN:
			player.move_down()
		Actions.MOVE_LEFT:
			player.move_left()
		Actions.MOVE_RIGHT:
			player.move_right()


func move_counter_clockwise() -> void:
	var temp = [up, right, down, left]
	up = temp[1]
	right = temp[2]
	down = temp[3]
	left = temp[0]
	
	moved_counter_clockwise.emit()


func move_clockwise() -> void:
	var temp = [up, right, down, left]
	up = temp[3]
	right = temp[0]
	down = temp[1]
	left = temp[2]
	
	moved_clockwise.emit()
