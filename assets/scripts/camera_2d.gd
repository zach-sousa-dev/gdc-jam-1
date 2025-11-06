extends Camera2D

@onready var options_instance = null
@onready var options_scene = preload("res://scenes/options.tscn")

func _ready():
	pass

func _process(delta):
	if options_instance != null:
		options_instance.position = position
