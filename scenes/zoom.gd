extends Camera2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_up"):
		zoom += Vector2(0.05, 0.05)
	if Input.is_action_just_pressed("move_down"):
		zoom -= Vector2(0.05, 0.05)
