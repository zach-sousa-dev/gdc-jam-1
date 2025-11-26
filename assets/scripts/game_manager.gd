extends Node

const KILL_QUOTA = 40
var num_killed = 0
var quota_str = ""

signal update_quota(quota_str)

func add_kill():
	num_killed += 1
	quota_str = str(num_killed) + "/" + str(KILL_QUOTA)
	emit_signal("update_quota", quota_str)
	
func _process(delta: float) -> void:
	if num_killed >= KILL_QUOTA:
		get_tree().change_scene_to_file("res://scenes/win.tscn")
		num_killed = 0
		quota_str = str(num_killed) + "/" + str(KILL_QUOTA)
