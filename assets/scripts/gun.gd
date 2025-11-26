extends Node2D

static var bullet_scene = preload("res://scenes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if(Input.is_action_just_pressed("fire")):
		$"../AudioStreamPlayer2D".play(0)
		var bullet = bullet_scene.instantiate()
		bullet.set_params(global_position, get_global_mouse_position())
		get_tree().current_scene.add_child(bullet)
