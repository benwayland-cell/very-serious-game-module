class_name  LevelSelectButton
extends Button

var level_num: int:
	set = _set_level_num


func _set_level_num(new_level_num) -> void:
	level_num = new_level_num
	text = str(level_num)
	if SceneManager.last_unlocked_level < level_num:
		disabled = true


func _on_pressed() -> void:
	if level_num != null:
		SceneManager.load_level(level_num)
