extends Node

signal moved_clockwise
signal moved_counter_clockwise
signal moved_vertically
signal moved_horizontally

@export var spin_animation_time: float = 0.5

enum Actions {NONE, MOVE_UP, MOVE_DOWN, MOVE_LEFT, MOVE_RIGHT}
enum SpinDirections {CLOCKWISE, COUNTER_CLOCKWISE, HORIZONTAL, VERTICAL}

var player: Player

var up: Actions
var down: Actions
var left: Actions
var right: Actions


func _ready() -> void:
	reset_actions()


func reset_actions() -> void:
	up = Actions.MOVE_UP
	down = Actions.MOVE_DOWN
	left = Actions.MOVE_LEFT
	right = Actions.MOVE_RIGHT


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


func spin(spin_direction: SpinDirections) -> void:
	match spin_direction:
		SpinDirections.CLOCKWISE:
			move_clockwise()
		SpinDirections.COUNTER_CLOCKWISE:
			move_counter_clockwise()
		SpinDirections.VERTICAL:
			move_vertically()
		SpinDirections.HORIZONTAL:
			move_horizontally()


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


func move_vertically() -> void:
	var temp = [up, down]
	up = temp[1]
	down = temp[0]
	
	moved_vertically.emit()


func move_horizontally() -> void:
	var temp = [left, right]
	left = temp[1]
	right = temp[0]
	
	moved_horizontally.emit()
