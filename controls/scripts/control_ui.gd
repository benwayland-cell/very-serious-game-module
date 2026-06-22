class_name ControlUI
extends MarginContainer

@onready var up_slot: ControlSlot = %ControlSlotUp
@onready var down_slot: ControlSlot = %ControlSlotDown
@onready var left_slot: ControlSlot = %ControlSlotLeft
@onready var right_slot: ControlSlot = %ControlSlotRight

# How many animations we're waiting to finish before updating
var animation_count: int = 0


func _ready() -> void:
	PlayerActions.moved_clockwise.connect(_on_player_actions_moved_clockwise)
	PlayerActions.moved_counter_clockwise.connect(_on_player_actions_moved_counter_clockwise)
	PlayerActions.moved_vertically.connect(_on_player_actions_moved_vertically)
	PlayerActions.moved_horizontally.connect(_on_player_actions_moved_horizontally)


func update_actions() -> void:
	up_slot.set_to_action(PlayerActions.up)
	down_slot.set_to_action(PlayerActions.down)
	left_slot.set_to_action(PlayerActions.left)
	right_slot.set_to_action(PlayerActions.right)


func _on_control_slot_animation_start() -> void:
	animation_count += 1


func _on_control_slot_animation_done() -> void:
	animation_count -= 1
	if (animation_count <= 0):
		animation_count = 0
		update_actions()


func _on_player_actions_moved_clockwise() -> void:
	var animation_time := PlayerActions.spin_animation_time
	up_slot.animate_moving_to(right_slot.global_position, animation_time)
	right_slot.animate_moving_to(down_slot.global_position, animation_time)
	down_slot.animate_moving_to(left_slot.global_position, animation_time)
	left_slot.animate_moving_to(up_slot.global_position, animation_time)


func _on_player_actions_moved_counter_clockwise() -> void:
	var animation_time := PlayerActions.spin_animation_time
	up_slot.animate_moving_to(left_slot.global_position, animation_time)
	right_slot.animate_moving_to(up_slot.global_position, animation_time)
	down_slot.animate_moving_to(right_slot.global_position, animation_time)
	left_slot.animate_moving_to(down_slot.global_position, animation_time)


func _on_player_actions_moved_vertically() -> void:
	var animation_time := PlayerActions.spin_animation_time
	up_slot.animate_moving_to(down_slot.global_position, animation_time)
	down_slot.animate_moving_to(up_slot.global_position, animation_time)


func _on_player_actions_moved_horizontally() -> void:
	var animation_time := PlayerActions.spin_animation_time
	left_slot.animate_moving_to(right_slot.global_position, animation_time)
	right_slot.animate_moving_to(left_slot.global_position, animation_time)
