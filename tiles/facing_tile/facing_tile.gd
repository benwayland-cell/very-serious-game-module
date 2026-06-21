@tool
extends StaticBody2D

@export var direction: Player.FacingDirections = Player.FacingDirections.UP

@onready var sprite: Sprite2D = %Sprite2D
@onready var area: Area2D = %Area2D

var old_direction: Player.FacingDirections
var player: Player


func _ready() -> void:
	if Engine.is_editor_hint():
		old_direction = direction
	
	player = get_tree().get_nodes_in_group("player")[0]
	
	_set_direction()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		if direction != old_direction:
			_set_direction()
		old_direction = direction
		return
	
	var colliding := player.facing_direction != direction
	if colliding:
		for body in area.get_overlapping_bodies():
			if body is Player:
				colliding = false
	
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
