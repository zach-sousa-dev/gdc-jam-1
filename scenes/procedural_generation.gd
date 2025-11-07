extends Node2D

const TILE_SIZE = 16

const WALL_SCENE: PackedScene = preload("res://scenes/test_wall.tscn")
const FLOOR_SCENE: PackedScene = preload("res://scenes/test_floor.tscn")

const MAP_WIDTH = 80
const MAP_HEIGHT = 80

const NUM_GENERATIONS = 4
# Alive represents walls, dead is floor.
const ALIVE_REMAINS_ALIVE_NUM_ALIVE_NEIGHBORS = 4
const DEAD_BECOMES_ALIVE_NUM_ALIVE_NEIGHBORS = 5
const INITIAL_ALIVE_PERCENT = 0.45

var map = []
var genNum = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map = initialize_map(MAP_WIDTH, MAP_HEIGHT, INITIAL_ALIVE_PERCENT)
	draw_map(TILE_SIZE, map, WALL_SCENE, FLOOR_SCENE)
	print("The map is " + str(map.size()) + " tiles by " + str(map[0].size()))
	print("You are looking at generation #" + str(genNum))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_down"):
		for child in get_children():
			child.queue_free()
		map = create_new_generation(map, ALIVE_REMAINS_ALIVE_NUM_ALIVE_NEIGHBORS, DEAD_BECOMES_ALIVE_NUM_ALIVE_NEIGHBORS)
		draw_map(TILE_SIZE, map, WALL_SCENE, FLOOR_SCENE)
		genNum += 1
		print("You are looking at generation #" + str(genNum))



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
				#print("Created a wall at: " + str(wall_instance.position))
			else:
				var floor_instance = floor.instantiate()
				floor_instance.position = Vector2(tile_scale * i, tile_scale * j)
				add_child(floor_instance)
				#print("Created a floor at: " + str(floor_instance.position))


# Running this once generates the next generation of cellular automata utilizing some
# pre-defined rules.
func create_new_generation(array: Array, stayAliveThreshold: int, becomeAliveThreshold) -> Array:
	for row in array.size() -1:
		for col in array[row].size() - 1:
			array[row][col] = calculate_state_using_rule(row, col, array, stayAliveThreshold, becomeAliveThreshold)
	return array



# Gathers all the neighboring cells and calculates the new state of a cell based
# on its neighbors.
func calculate_state_using_rule(row: int, col: int, array: Array, stayAliveThreshold: int, becomeAliveThreshold) -> bool:
	var numAlive = 0
	var neighbors = gather_neighbors(row, col, array)
	var cell = array[row][col]
	
	for neighbor in neighbors:
		if neighbor:
			numAlive += 1
			
	if cell == true and numAlive < stayAliveThreshold:
		cell = false
	elif cell == false and numAlive >= becomeAliveThreshold:
		cell = true
		
	return cell



# Get an array of all the neighboring values based on the position of the original
# cell. Array should be rectangular (all rows should be the same length).
func gather_neighbors(row: int, col: int, array: Array) -> Array:
	var WIDTH = array.size()
	var HEIGHT = array[0].size()
	var neighbors = [
			0, 1, 2, # Row of northern neighbors.
			3,    4, # Row of west and east neighbors (the middle is the original cell).
			5, 6, 7  # Row of southern neighbors.
		]            # NOTE: This is NOT a 2D array.
	# Top row
	neighbors[0] = array[(row + -1 + HEIGHT) % HEIGHT][(col + -1 + WIDTH) % WIDTH]
	neighbors[1] = array[(row + -1 + HEIGHT) % HEIGHT][(col +  0 + WIDTH) % WIDTH]
	neighbors[2] = array[(row + -1 + HEIGHT) % HEIGHT][(col +  1 + WIDTH) % WIDTH]
	
	# Middle row
	neighbors[3] = array[(row + 0 + HEIGHT) % HEIGHT][(col + -1 + WIDTH) % WIDTH]
	neighbors[4] = array[(row + 0 + HEIGHT) % HEIGHT][(col +  1 + WIDTH) % WIDTH]
	
	# Bottom row
	neighbors[5] = array[(row + 1 + HEIGHT) % HEIGHT][(col + -1 + WIDTH) % WIDTH]
	neighbors[6] = array[(row + 1 + HEIGHT) % HEIGHT][(col +  0 + WIDTH) % WIDTH]
	neighbors[7] = array[(row + 1 + HEIGHT) % HEIGHT][(col +  1 + WIDTH) % WIDTH]
	
	return neighbors
