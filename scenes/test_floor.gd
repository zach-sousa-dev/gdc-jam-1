extends Node2D

const enemy_scene = preload("res://scenes/basic_enemy.tscn")

func _process(delta: float) -> void:
	if $Timer.is_stopped():
		$Timer.start()
		var rng = RandomNumberGenerator.new()
		var random_int = rng.randi_range(1, 100)
		if random_int == 1:
			var enemy = enemy_scene.instantiate()
			enemy.spawn_position(position)
			get_tree().current_scene.add_child(enemy)
