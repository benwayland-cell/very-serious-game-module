@tool
class_name SpinTile
extends Area2D

@export var spin_direction := PlayerActions.SpinDirections.CLOCKWISE

@onready var sprite: Sprite2D = %Sprite2D

var old_spin_direction: PlayerActions.SpinDirections


func _ready() -> void:
	if Engine.is_editor_hint():
		old_spin_direction = spin_direction
	
	_setup_sprite()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if old_spin_direction != spin_direction:
			_setup_sprite()
		old_spin_direction = spin_direction


func _setup_sprite() -> void:
	sprite.flip_h = false
	sprite.rotation = 0
	
	match spin_direction: 
		PlayerActions.SpinDirections.CLOCKWISE:
			sprite.texture = SpinTileSprites.COUNTER_CLOCKWISE_SPRITE
			sprite.flip_h = true
		PlayerActions.SpinDirections.COUNTER_CLOCKWISE:
			sprite.texture = SpinTileSprites.COUNTER_CLOCKWISE_SPRITE
		PlayerActions.SpinDirections.HORIZONTAL:
			sprite.texture = SpinTileSprites.VERTICAL_SPRITE
			sprite.rotation_degrees = 90
		PlayerActions.SpinDirections.VERTICAL:
			sprite.texture = SpinTileSprites.VERTICAL_SPRITE


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	PlayerActions.spin(spin_direction)
	var tween: Tween = create_tween()
	tween.tween_property(
		body, "global_position",
		global_position,
		PlayerActions.spin_animation_time
	)
