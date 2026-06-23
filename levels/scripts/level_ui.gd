class_name LevelUi
extends Control

@onready var dimmer: ColorRect = %Dimmer
@onready var win_screen: MarginContainer = %WinScreen
@onready var pause_screen: MarginContainer = %PauseScreen


var paused := false
var first_frame_of_pause := false


func _ready() -> void:
	dimmer.hide()
	win_screen.hide()
	pause_screen.hide()


func _process(_delta: float) -> void:
	if paused:
		if first_frame_of_pause:
			first_frame_of_pause = false
			return
		if Input.is_action_just_pressed("pause"):
			_on_continue_button_pressed()


func win() -> void:
	win_screen.show()


func pause() -> void:
	paused = true
	first_frame_of_pause = true
	dimmer.show()
	pause_screen.show()
	get_tree().paused = true


func _on_continue_button_pressed() -> void:
	get_tree().paused = false
	dimmer.hide()
	win_screen.hide()
	pause_screen.hide()
	paused = false


func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.load_next_level()


func _on_level_select_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.load_level_select()
