class_name ControlSlot
extends TextureRect

@export var initial_action: PlayerActions.Actions

@onready var child_texture: TextureRect = %ChildTexture

func _ready() -> void:
	set_to_action(initial_action)


func set_to_action(action: PlayerActions.Actions) -> void:
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
