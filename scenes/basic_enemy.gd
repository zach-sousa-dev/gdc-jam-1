extends CharacterBody2D

const SPEED = 4300

var hp = 3

var Destination: Node = null

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	Destination = players[0]
	$NavigationAgent2D.target_position = Destination.global_position
	
	
func _physics_process(delta: float) -> void:
	if $NavigationAgent2D.is_target_reached() && $StunTimer.is_stopped():
		sprite.play("stand")
		
	if  !$StunTimer.is_stopped():
		sprite.play("hurt")
		velocity = Vector2.ZERO
		
	if !$NavigationAgent2D.is_target_reached() && $StunTimer.is_stopped():
		sprite.play("run")
		var direction = to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity = direction * SPEED * delta
		move_and_slide()
	
	var bodies = $Area2D.get_overlapping_bodies()
	for body in bodies:
		if $DealDamageTimer.is_stopped() && body.is_in_group("Player"):
			$DealDamageTimer.start()
			var dir = (Destination.global_position - global_position).normalized()
			body.take_damage()


func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position != Destination.global_position:
		$NavigationAgent2D.target_position = Destination.global_position
	$RedirectTimer.start()
	
func take_damage() -> void:
	hp -= 1
	$StunTimer.start()
	
	if hp <= 0:
		GameManager.add_kill()
		queue_free()
	


func _on_stun_timer_timeout() -> void:
	pass # Replace with function body.


func _on_deal_damage_timer_timeout() -> void:
	pass # Replace with function body.
	
func spawn_position(spawn: Vector2) -> void:
	position = spawn
	
