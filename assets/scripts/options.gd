extends Control

@onready var resume_button = $ResumeButton

func _ready(): 
	resume_button.connect("pressed", Callable(self, "_on_resume_pressed"))
	
func _on_resume_pressed():
	get_tree().paused = false
	queue_free()
