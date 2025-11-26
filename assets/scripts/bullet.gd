extends Area2D

var dir = Vector2(0,0)
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += dir * speed * delta

func set_params(start_pos: Vector2, end_pos: Vector2) -> void:
	position = start_pos
	var temp = end_pos - start_pos
	dir = temp.normalized()
	


func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Player"):
		if body.is_in_group("Enemy"):
			body.take_damage()
		queue_free()
		
