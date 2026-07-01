extends Node

const MAIN_MENU_SCENE: PackedScene = preload("uid://420xfjr34tdo")
const LEVEL_SELECT_SCENE: PackedScene = preload("uid://bbv1xyasog5fk")
const LORE_TEXT_SCENE: PackedScene = preload("uid://k7ikhbvhbd5r")
const WIN_TEXT_SCENE: PackedScene = preload("uid://co4gsrqw0umsl")
const CREDITS_SCENE: PackedScene = preload("uid://cktsdsotodvda")

const LEVEL_PATH: String = "res://levels/level_scenes/level"

var LEVEL_SCENE_PATHS: Array[String] = [
	"res://levels/level_scenes/level1.tscn",
	"res://levels/level_scenes/level2.tscn",
	"res://levels/level_scenes/level3.tscn",
	"res://levels/level_scenes/level4.tscn",
	"res://levels/level_scenes/level5.tscn",
	"res://levels/level_scenes/level6.tscn",
] 

var level_scenes: Array[PackedScene] = []


var current_level: int = 0
var last_unlocked_level: int = 0:
	set = _set_last_unlocked_level


func _ready() -> void:
	_load_level_scenes()
	load_game()
	
	# debug
	if Input.is_action_just_pressed("debug1"):
		last_unlocked_level = level_scenes.size()


func _load_level_scenes() -> void:
	for path: String in LEVEL_SCENE_PATHS:
		level_scenes.append(load(path))
	
	#var current_num: int = 0
	#while true:
		#current_num += 1
		#var current_level_path := LEVEL_PATH + str(current_num) + ".tscn"
		#if not FileAccess.file_exists(current_level_path):
			#break
		#level_scenes.append(load(current_level_path))


func hide_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func show_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func load_main_menu_scene() -> void:
	current_level = 0
	show_mouse()
	get_tree().change_scene_to_packed(MAIN_MENU_SCENE)


func load_level_select() -> void:
	current_level = 0
	show_mouse()
	get_tree().change_scene_to_packed(LEVEL_SELECT_SCENE)


func load_credits() -> void:
	current_level = 0
	show_mouse()
	get_tree().change_scene_to_packed(CREDITS_SCENE)


func load_level(level_num: int) -> void:
	show_mouse()
	if level_num == 0:
		get_tree().change_scene_to_packed(LORE_TEXT_SCENE)
		return
	
	if level_num == level_scenes.size() + 1:
		get_tree().change_scene_to_packed(WIN_TEXT_SCENE)
		return
	
	if level_num < 0 or level_num > level_scenes.size():
		load_main_menu_scene()
		return
	
	hide_mouse()
	current_level = level_num
	get_tree().change_scene_to_packed(level_scenes[level_num - 1])


func load_next_level() -> void:
	load_level(current_level + 1)


func load_last_unlocked_level() -> void:
	load_level(last_unlocked_level)


func unlock_next_level() -> void:
	last_unlocked_level = min(
			max(last_unlocked_level, current_level + 1),
			level_scenes.size() + 1
		)


func _set_last_unlocked_level(new_last_unlocked_level: int) -> void:
	last_unlocked_level = min(new_last_unlocked_level, level_scenes.size())
	save_game()


func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(str(last_unlocked_level))


func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	last_unlocked_level = int(save_file.get_line())
