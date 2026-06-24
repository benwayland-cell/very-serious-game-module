extends Control

@export var wrap_num: int = 5

const LEVEL_SELECT_BUTTON_SCENE: PackedScene = preload("uid://bckp8stgtf3bs")

@onready var buttons_v_box: VBoxContainer = %ButtonsVBox


func _ready() -> void:
	var current_h_box_container: HBoxContainer
	
	for level_num: int in range(1, SceneManager.level_scenes.size() + 1):
		if (level_num - 1) % wrap_num == 0:
			current_h_box_container = HBoxContainer.new()
			buttons_v_box.add_child(current_h_box_container)
		
		var new_button: LevelSelectButton = LEVEL_SELECT_BUTTON_SCENE.instantiate()
		new_button.level_num = level_num
		current_h_box_container.add_child(new_button)


func _on_back_button_pressed() -> void:
	SceneManager.load_main_menu_scene()
