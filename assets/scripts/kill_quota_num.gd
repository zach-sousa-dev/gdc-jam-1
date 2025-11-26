extends Label


func _ready():
	GameManager.update_quota.connect(update_quota_label)
	
func update_quota_label(message):
	text = message
