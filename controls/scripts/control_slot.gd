class_name ControlSlot
extends TextureRect

signal animation_start
signal animation_done

@export var initial_action: PlayerActions.Actions

@onready var child_texture: TextureRect = %ChildTexture

func _ready() -> void:
	set_to_action(initial_action)


var timer = 0
var debug = false
func _process(delta: float) -> void:
	if name != "ControlSlotUp": return
	
	timer += delta
	
	if child_texture.global_position == Vector2.ZERO and not debug:
		print(timer)
		debug = true


func set_to_action(action: PlayerActions.Actions) -> void:
	child_texture.position = Vector2.ZERO
	child_texture.flip_h = false
	child_texture.flip_v = false
	
	match action:
		PlayerActions.Actions.MOVE_UP:
			child_texture.texture = ControlSprites.ARROW_SPRITE_V
		PlayerActions.Actions.MOVE_DOWN:
			child_texture.texture = ControlSprites.ARROW_SPRITE_V
			child_texture.flip_v = true
		PlayerActions.Actions.MOVE_LEFT:
			child_texture.texture = ControlSprites.ARROW_SPRITE_H
			child_texture.flip_h = true
		PlayerActions.Actions.MOVE_RIGHT:
			child_texture.texture = ControlSprites.ARROW_SPRITE_H


func animate_moving_to(global_position_to_move_to: Vector2, animation_time: float) -> void:
	var tween = create_tween()
	tween.tween_property(
		child_texture, "global_position",
		global_position_to_move_to,
		animation_time
	)
	tween.finished.connect(on_tween_finished)
	animation_start.emit()


func on_tween_finished() -> void:
	animation_done.emit()
