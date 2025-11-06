extends Node2D

const TILE_SIZE = 16

const WALL_SCENE: PackedScene = preload("res://scenes/test_wall.tscn")
const FLOOR_SCENE: PackedScene = preload("res://scenes/test_floor.tscn")

const MAP_WIDTH = 100
const MAP_HEIGHT = 100

const NUM_GENERATIONS = 4
# Alive represents walls, dead is floor.
const ALIVE_REMAINS_ALIVE_NUM_ALIVE_NEIGHBORS = 4
const DEAD_BECOMES_ALIVE_NUM_ALIVE_NEIGHBORS = 5
const INITIAL_ALIVE_PERCENT = 0.45

var map = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map = initialize_map(MAP_WIDTH, MAP_HEIGHT, INITIAL_ALIVE_PERCENT)
	draw_map(TILE_SIZE, map, WALL_SCENE, FLOOR_SCENE)
	print("There are this many rows: " + str(map.size()))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
# Fills the map with random tiles reprenting either alive or dead. Tiles have a
# 'chance' percent chance of being alive, otherwise they are dead.
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

# Draws the map by instantiating walls or floors based on if the cell is true (wall)
# or false (floor). Each object is spawned at the position 
# (x-index * tile_scale, y-index * tile_scale)
func draw_map(tile_scale: int, array: Array, wall: PackedScene, floor: PackedScene) -> void:
	for i in array.size() - 1:
		for j in array[i].size() - 1:
			if(array[i][j]):
				var wall_instance = wall.instantiate()
				wall_instance.position = Vector2(tile_scale * i, tile_scale * j)
				add_child(wall_instance)
				print("Created a wall at: " + str(wall_instance.position))
			else:
				var floor_instance = floor.instantiate()
				floor_instance.position = Vector2(tile_scale * i, tile_scale * j)
				add_child(floor_instance)
				print("Created a floor at: " + str(floor_instance.position))
			
	

			
	
	
