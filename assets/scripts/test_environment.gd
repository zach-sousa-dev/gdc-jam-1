extends Node2D

@onready var options_scene = preload("res://scenes/options.tscn")
var options_instance = null

@onready var camera = $Player/Camera2D
@onready var player = $Player

const GAMEPLAY_ZOOM = 1

func _ready():
	set_process_unhandled_input(true)
	camera.zoom = Vector2(GAMEPLAY_ZOOM, GAMEPLAY_ZOOM)
	get_tree().root.get_viewport().canvas_cull_mask &= ~(1 << 19)
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_options()
		get_viewport().set_input_as_handled()

func toggle_options():
	if options_instance == null:
		get_tree().paused = true
		
		options_instance = options_scene.instantiate();
		
		add_child(options_instance)
		
		options_instance.process_mode = Node.PROCESS_MODE_ALWAYS
		
		options_instance.position = camera.global_position
	else:
		if options_instance != null:
			options_instance.queue_free()
			await get_tree().process_frame
			options_instance = null
		get_tree().paused = false
