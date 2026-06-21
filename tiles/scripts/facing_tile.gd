@tool
extends StaticBody2D

@export var direction: Player.FacingDirections = Player.FacingDirections.UP
@export var faded_amount: float = 0.5

@onready var sprite: Sprite2D = %Sprite2D
@onready var area: Area2D = %Area2D

var old_direction: Player.FacingDirections
var player: Player


func _ready() -> void:
	if Engine.is_editor_hint():
		old_direction = direction
	
	player = get_tree().get_first_node_in_group("player")
	
	_set_direction()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if direction != old_direction:
			_set_direction()
		old_direction = direction
		return
	
	var colliding := player.facing_direction != direction
	if colliding:
		modulate.a = 1
		for body in area.get_overlapping_bodies():
			if body is Player:
				colliding = false
	else:
		modulate.a = faded_amount
	
	set_collision_layer_value(1, colliding)


func _set_direction() -> void:
	match direction:
		Player.FacingDirections.UP:
			sprite.rotation_degrees = 0
		Player.FacingDirections.RIGHT:
			sprite.rotation_degrees = 90
		Player.FacingDirections.DOWN:
			sprite.rotation_degrees = 180
		Player.FacingDirections.LEFT:
			sprite.rotation_degrees = 270
