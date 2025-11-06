extends Node2D

const TILE_SIZE = 16

const WALL_SCENE: PackedScene = preload("res://scenes/test_wall.tscn")
const FLOOR_SCENE: PackedScene = preload("res://scenes/test_floor.tscn")

const MAP_WIDTH = 256
const MAP_HEIGHT = 256

const NUM_GENERATIONS = 4
# Alive represents walls, dead is floor.
const ALIVE_REMAINS_ALIVE_NUM_ALIVE_NEIGHBORS = 4
const DEAD_BECOMES_ALIVE_NUM_ALIVE_NEIGHBORS = 5
const INITIAL_ALIVE_PERCENT = 0.45

var map = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map = initialize_map(MAP_WIDTH, MAP_HEIGHT, INITIAL_ALIVE_PERCENT)
	draw_map(TILE_SIZE, map)
	print("There are this many rows: " + str(map.size()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func initialize_map(width: int, height: int, chance: float) -> Array:
	var array = []
	for i in height:
		var row = []
		for j in width:
			var rng = RandomNumberGenerator.new()
			var randomNumber = rng.randf()
			var isAlive = randomNumber <= chance
			row.append(isAlive)
		array.append(row)
	return array

func draw_map(tile_scale: int, array: Array) -> void:
	for i in array.size() - 1:
		for j in array[i].size() - 1:
			if(array[i][j]):
				var wall_instance = WALL_SCENE.instantiate()
				wall_instance.position = Vector2(tile_scale * i, tile_scale * j)
				add_child(wall_instance)
				print("Created a wall at: " + str(wall_instance.position))
			else:
				var floor_instance = FLOOR_SCENE.instantiate()
				floor_instance.position = Vector2(tile_scale * i, tile_scale * j)
				add_child(floor_instance)
				print("Created a floor at: " + str(floor_instance.position))
			
	

			
	
	
