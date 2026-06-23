extends Control


func _on_new_continue_button_pressed() -> void:
	SceneManager.load_last_unlocked_level()


func _on_level_select_button_pressed() -> void:
	SceneManager.load_level_select()
