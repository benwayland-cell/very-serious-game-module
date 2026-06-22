class_name Player
extends CharacterBody2D

enum FacingDirections {UP, DOWN, LEFT, RIGHT}

@export var speed: float = 100.0
@export var spin_speed: int = 2

var viewport_rect: Rect2
var player_size: Vector2

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

@onready var spin_timer: Timer = %SpinTimer
var is_spinning: bool = false

var facing_direction: FacingDirections = FacingDirections.UP
var direction: Vector2 = Vector2.ZERO

var input_stack: Array[String] = []
const INPUTS: Array[String] = ["up", "down", "left", "right"]
const INPUTS_FACING_DIRECTIONS: Array[FacingDirections] = (
		[FacingDirections.UP, FacingDirections.DOWN, FacingDirections.LEFT, FacingDirections.RIGHT])


func _ready() -> void:
	viewport_rect = get_viewport_rect()
	player_size = %CollisionShape2D.shape.size
	
	spin_timer.wait_time = PlayerActions.spin_animation_time
	
	PlayerActions.player = self
	PlayerActions.moved_clockwise.connect(_on_player_actions_moved_clockwise)
	PlayerActions.moved_counter_clockwise.connect(_on_player_actions_moved_counter_clockwise)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug1"):
		PlayerActions.move_clockwise()
	if Input.is_action_just_pressed("debug2"):
		PlayerActions.move_counter_clockwise()
	
	if is_spinning:
		return
	
	_handle_facing_direction()
	_handle_animation()
	_handle_movement()


func _handle_facing_direction() -> void:
	for input in INPUTS:
		if Input.is_action_just_pressed(input):
			input_stack.append(input)
		if not Input.is_action_pressed(input):
			input_stack.erase(input)
	
	if input_stack.size() > 0:
		var current_input := input_stack[-1]
		facing_direction = _input_to_facing_direction(current_input)


func _input_to_facing_direction(input: String) -> FacingDirections:
	return INPUTS_FACING_DIRECTIONS[INPUTS.find(input)]


func _handle_animation() -> void:
	if input_stack.size() > 0:
		animated_sprite.play(input_stack[-1])


func _handle_movement() -> void:
	direction = Vector2.ZERO
	if input_stack.size() > 0:
		PlayerActions.do_action(_input_to_facing_direction(input_stack[-1]))
	
	velocity = direction * speed
	move_and_slide()
	_keep_on_screen()


func _keep_on_screen() -> void:
	if position.x <= 0:
		position.x = 0
	if position.y <= 0:
		position.y = 0
	if position.x >= viewport_rect.size.x - player_size.x:
		position.x = viewport_rect.size.x - player_size.x
	if position.y >= viewport_rect.size.y - player_size.y:
		position.y = viewport_rect.size.y - player_size.y


func _on_spin_timer_timeout() -> void:
	if input_stack.size() > 0:
		animated_sprite.play(input_stack[-1])
	else:
		animated_sprite.play("up")
	
	is_spinning = false


func _on_player_actions_moved_clockwise() -> void:
	animated_sprite.play("spin_clockwise")
	spin_timer.start()
	is_spinning = true


func _on_player_actions_moved_counter_clockwise() -> void:
	animated_sprite.play("spin_counter_clockwise")
	spin_timer.start()
	is_spinning = true


######### Actions


func move_up() -> void:
	direction = Vector2.UP


func move_down() -> void:
	direction = Vector2.DOWN


func move_left() -> void:
	direction = Vector2.LEFT


func move_right() -> void:
	direction = Vector2.RIGHT
