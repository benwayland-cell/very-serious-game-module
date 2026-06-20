class_name Player
extends CharacterBody2D

@export var speed: float = 100.0

var direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	PlayerActions.player = self


func _process(_delta: float) -> void:
	direction = Vector2.ZERO
	
	if Input.is_action_just_pressed("debug1"):
		PlayerActions.move_clockwise()
	if Input.is_action_just_pressed("debug2"):
		PlayerActions.move_counter_clockwise()
	
	PlayerActions.run_actions()
	
	_handle_movement()


func _handle_movement() -> void:
	velocity = direction * speed
	move_and_slide()


######### Actions


func move_up() -> void:
	direction += Vector2.UP


func move_down() -> void:
	direction += Vector2.DOWN


func move_left() -> void:
	direction += Vector2.LEFT


func move_right() -> void:
	direction += Vector2.RIGHT
