class_name LevelUi
extends Control

@onready var dimmer: ColorRect = %Dimmer
@onready var win_screen: MarginContainer = %"Win Screen"


func _ready() -> void:
	dimmer.hide()
	win_screen.hide()

func win() -> void:
	#dimmer.show()
	win_screen.show()


func _on_next_level_button_pressed() -> void:
	SceneManager.load_next_level()


func _on_level_select_button_pressed() -> void:
	SceneManager.load_level_select()
