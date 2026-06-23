extends Node

const MAIN_MENU_SCENE: PackedScene = preload("uid://420xfjr34tdo")
const LEVEL_SELECT_SCENE: PackedScene = preload("uid://bbv1xyasog5fk")

const LEVEL_PATH: String = "res://levels/level_scenes/level"

var level_scenes: Array[PackedScene] = []


var current_level: int = 0
var last_unlocked_level: int = 1


func _ready() -> void:
	var current_num: int = 0
	while true:
		current_num += 1
		var current_level_path := LEVEL_PATH + str(current_num) + ".tscn"
		if not FileAccess.file_exists(current_level_path):
			break
		level_scenes.append(load(current_level_path))


func load_main_menu_scene() -> void:
	current_level = 0
	get_tree().change_scene_to_packed(MAIN_MENU_SCENE)


func load_level_select() -> void:
	current_level = 0
	get_tree().change_scene_to_packed(LEVEL_SELECT_SCENE)


func load_level(level_num: int) -> void:
	if level_num <= 0 or level_num > level_scenes.size():
		load_main_menu_scene()
		return
	
	current_level = level_num
	get_tree().change_scene_to_packed(level_scenes[level_num - 1])


func load_next_level() -> void:
	load_level(current_level + 1)


func load_last_unlocked_level() -> void:
	load_level(last_unlocked_level)


func unlock_next_level() -> void:
	last_unlocked_level = max(last_unlocked_level, current_level + 1)
