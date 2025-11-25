extends SubViewport

@onready var player = $"../../../Player"

@onready var camera = $Camera2D

func _ready() -> void:
	world_2d = get_tree().root.world_2d
