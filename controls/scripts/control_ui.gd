class_name ControlUI
extends MarginContainer

@onready var up_slot: ControlSlot = %ControlSlotUp
@onready var down_slot: ControlSlot = %ControlSlotDown
@onready var left_slot: ControlSlot = %ControlSlotLeft
@onready var right_slot: ControlSlot = %ControlSlotRight


func _ready() -> void:
	PlayerActions.updated.connect(on_player_actions_updated)


func on_player_actions_updated() -> void:
	up_slot.set_to_action(PlayerActions.up)
	down_slot.set_to_action(PlayerActions.down)
	left_slot.set_to_action(PlayerActions.left)
	right_slot.set_to_action(PlayerActions.right)
