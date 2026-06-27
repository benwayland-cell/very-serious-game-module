extends Control

func _ready() -> void:
	if SceneManager.last_unlocked_level > 0:
		%"New-ContinueButton".text = "Continue"

func _on_new_continue_button_pressed() -> void:
	SceneManager.load_last_unlocked_level()


func _on_level_select_button_pressed() -> void:
	SceneManager.load_level_select()


func _on_custom_button_pressed() -> void:
	SceneManager.last_unlocked_level = 1
	%"New-ContinueButton".text = "New Game"
