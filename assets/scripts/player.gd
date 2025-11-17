extends CharacterBody2D


const SPEED = 100.0

@onready var PLAYER_SPRITE = $'AnimatedSprite2D' 
@onready var GUN_PARENT = $'GunParent' 
@onready var GUN_PARENT_ORIGINAL_SCALE_X = GUN_PARENT.scale.x

func _process(delta: float) -> void:
	if get_global_mouse_position().x < position.x:
		PLAYER_SPRITE.flip_h = true
		GUN_PARENT.scale.x = -GUN_PARENT_ORIGINAL_SCALE_X
	else:
		PLAYER_SPRITE.flip_h = false
		GUN_PARENT.scale.x = GUN_PARENT_ORIGINAL_SCALE_X

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
