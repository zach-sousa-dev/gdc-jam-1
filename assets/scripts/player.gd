extends CharacterBody2D


const SPEED = 100.0
const SELECTION_SPEED = 300.0

var current_speed = SELECTION_SPEED

var hp = 3
const MAX_HP = 3

@onready var PLAYER_SPRITE = $'AnimatedSprite2D' 
@onready var GUN_PARENT = $'GunParent' 
@onready var COLLIDER = $'CollisionShape2D' 
@onready var GUN_PARENT_ORIGINAL_SCALE_X = GUN_PARENT.scale.x

@onready var music = $Music

var spawn_selected = false

func _process(delta: float) -> void:
	COLLIDER.disabled = !spawn_selected
	
	if(spawn_selected && hp > 0):
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
	if direction && hp > 0:
		if(spawn_selected): PLAYER_SPRITE.play("walk")
		velocity = direction * current_speed
	else:
		if(spawn_selected):PLAYER_SPRITE.play("stand")
		if(hp <= 0): PLAYER_SPRITE.play("dead")
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
	
	if hp <= 0 && $DeathTimer.is_stopped():
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
		
	if Input.is_action_just_pressed("suicide"):
		hp = 0

	move_and_slide()

func take_damage() -> void:
	if hp > 0: 
		hp -= 1
		$HitSound.play(0)
		print("hit")
		if hp <=0:
			$DeathTimer.start()
			music.stop()
			$DeathSound.play(0)
			GUN_PARENT.queue_free()
