extends CharacterBody2D


const SPEED = 100.0
const SELECTION_SPEED = 300.0

var current_speed = SELECTION_SPEED

@onready var PLAYER_SPRITE = $'AnimatedSprite2D' 
@onready var GUN_PARENT = $'GunParent' 
@onready var GUN_PARENT_ORIGINAL_SCALE_X = GUN_PARENT.scale.x

var spawn_selected = false

func _process(delta: float) -> void:
	if(spawn_selected):
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
		if(spawn_selected): PLAYER_SPRITE.play("walk")
		velocity = direction * current_speed
	else:
		if(spawn_selected):PLAYER_SPRITE.play("stand")
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.y = move_toward(velocity.y, 0, current_speed)
		
	if(!spawn_selected):
		PLAYER_SPRITE.play("point")
		current_speed = SELECTION_SPEED
		GUN_PARENT.hide()
		if(Input.is_action_just_pressed("fire")):
			spawn_selected = true
			current_speed = SPEED
			GUN_PARENT.show()

	move_and_slide()
