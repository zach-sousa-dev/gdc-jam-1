extends CharacterBody2D


const SPEED = 100.0


func _physics_process(delta: float) -> void:
	var xDirection := Input.get_axis("move_left", "move_right")
	var yDirection := Input.get_axis("move_up", "move_down")
	
	var direction = Vector2(xDirection, yDirection).normalized()
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
