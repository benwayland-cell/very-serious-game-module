extends Level

@onready var spawn_point: Node2D = %SpawnPoint
@export var spawn_dimensions := Vector2i(6, 3)

var SPIN_TILE_SCENE: PackedScene = preload("uid://sp5626vpyl51")

func _ready() -> void:
	super._ready()
	
	var initial_pos: Vector2 = spawn_point.position
	
	for x in range(spawn_dimensions.x):
		for y in range(spawn_dimensions.y):
			spawn_spin_tile(Vector2(
				initial_pos.x + x * 16.0,
				initial_pos.y + y * 16.0
			))


func spawn_spin_tile(pos: Vector2) -> void:
	var new_spin_tile: SpinTile = SPIN_TILE_SCENE.instantiate()
	add_child(new_spin_tile)
	new_spin_tile.position = pos
	var rand_num: int = randi_range(0, 3)
	new_spin_tile.spin_direction = rand_num as PlayerActions.SpinDirections
	new_spin_tile._setup_sprite()
