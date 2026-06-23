class_name Player
extends CharacterBody2D

signal won

@export var speed: float = 0.3
@export var win_bigger_speed: float = 1.05
@export var win_timer_time: float = 0.5

enum FacingDirections {UP, DOWN, LEFT, RIGHT}

const INPUTS: Array[String] = ["up", "down", "left", "right"]
const INPUT_TO_FACING_DIRECTION: Dictionary[String, FacingDirections] = {
	"up": FacingDirections.UP,
	"down": FacingDirections.DOWN,
	"left": FacingDirections.LEFT,
	"right": FacingDirections.RIGHT,
}

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var ray: RayCast2D = %RayCast2D
@onready var spin_timer: Timer = %SpinTimer
@onready var win_anim_timer: Timer = %WinAnimTimer

var level_size: Vector2i
var tile_size: int
var current_pos: Vector2i

var is_spinning: bool = false

var facing_direction: FacingDirections = FacingDirections.UP
var direction: Vector2i = Vector2i.ZERO:
	set = _set_direction
var moving: bool = false

var input_stack: Array[String] = []
var any_button_is_pressed: bool = false

var has_won: bool = false


func _ready() -> void:
	var viewport_rect: Rect2 = get_viewport_rect()
	tile_size = %CollisionShape2D.shape.size.x
	level_size = Vector2i(
				int(viewport_rect.size.x / tile_size),
				int(viewport_rect.size.y / tile_size),
			)
	current_pos = global_position / tile_size
	
	spin_timer.wait_time = PlayerActions.spin_animation_time
	
	PlayerActions.player = self
	PlayerActions.moved_clockwise.connect(_on_player_actions_moved_clockwise)
	PlayerActions.moved_counter_clockwise.connect(_on_player_actions_moved_counter_clockwise)
	PlayerActions.moved_vertically.connect(_on_player_actions_moved_vertically)
	PlayerActions.moved_horizontally.connect(_on_player_actions_moved_horizontally)


func _process(_delta: float) -> void:
	if has_won:
		_handle_win_animation()
		return
	
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
		facing_direction = INPUT_TO_FACING_DIRECTION[current_input]
		any_button_is_pressed = true
	else:
		any_button_is_pressed = false


func _handle_animation() -> void:
	if any_button_is_pressed:
		animated_sprite.play(input_stack[-1])


func _handle_movement() -> void:
	direction = Vector2.ZERO
	if any_button_is_pressed:
		PlayerActions.do_action(facing_direction)
		_move_player()
	
	move_and_slide()


func _move_player() -> void:
	if moving:
		return
	
	var target_pos: Vector2i = current_pos + direction
	if not _can_move(target_pos):
		return
	
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_position", Vector2(target_pos * tile_size), speed)
	moving = true
	tween.tween_callback(_stop_moving)
	current_pos = target_pos


func _stop_moving() -> void:
	moving = false


func _can_move(target_pos: Vector2i) -> bool:
	return not (
			target_pos.x < 0 or
			target_pos.y < 0 or 
			target_pos.x >= level_size.x or
			target_pos.y >= level_size.y or
			ray.is_colliding()
		)


func _on_spin_timer_timeout() -> void:
	if any_button_is_pressed:
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


func _on_player_actions_moved_vertically() -> void:
	animated_sprite.play("spin_vertical")
	spin_timer.start()
	is_spinning = true


func _on_player_actions_moved_horizontally() -> void:
	animated_sprite.play("spin_horizontal")
	spin_timer.start()
	is_spinning = true


func _set_direction(new_direction: Vector2i) -> void:
	direction = new_direction
	if direction:
		ray.target_position = direction * tile_size
		ray.force_raycast_update()


func win() -> void:
	has_won = true
	animated_sprite.play("spin_clockwise")
	win_anim_timer.start()


func _handle_win_animation() -> void:
	animated_sprite.scale *= win_bigger_speed


func _on_win_anim_timer_timeout() -> void:
	won.emit()


######### Actions


func move_up() -> void:
	direction = Vector2.UP


func move_down() -> void:
	direction = Vector2.DOWN


func move_left() -> void:
	direction = Vector2.LEFT


func move_right() -> void:
	direction = Vector2.RIGHT
