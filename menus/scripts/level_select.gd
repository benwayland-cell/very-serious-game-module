extends Control


func _on_back_button_pressed() -> void:
	SceneManager.load_main_menu_scene()


func _on_button_1_pressed() -> void:
	SceneManager.load_level(1)


func _on_button_2_pressed() -> void:
	SceneManager.load_level(2)
