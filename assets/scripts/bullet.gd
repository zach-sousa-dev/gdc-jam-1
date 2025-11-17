extends CharacterBody2D

var start = Vector2(0, 0)
var end = Vector2(0,0)
var dir = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = dir * 1

func with_params(start_pos: Vector2, end_pos: Vector2) -> void:
	start = start_pos
	end = end_pos
	var temp = end - start
	dir = temp.normalized()
	
