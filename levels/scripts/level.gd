class_name Level
extends Node2D

var player: Player
@onready var level_ui: LevelUi = %LevelUi


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	assert(player != null, "There is no player")
	assert(level_ui != null, "There is no level UI")
	
	level_ui.show()
	player.won.connect(_on_player_won)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("undo"):
		get_tree().reload_current_scene()


func _on_player_won() -> void:
	SceneManager.unlock_next_level()
	level_ui.win()
