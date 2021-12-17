extends Node2D

var update_time = false
var text_only = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_Timer_timeout():
	visible = false
	queue_free()

func flashText(message, show_time_remaining = false):
	# Display on some random coordinate away from center
	var offset = randi() % 30
	if randi() % 2:	
		offset = -offset
	position.x += offset
	
	offset = randi() % 30
	if randi() % 2:	
		offset = -offset
	position.y += offset
	
	visible = true
	text_only = message
	$Label.text = text_only
	$Timer.start(1)
	update_time = show_time_remaining
	
	$Tween.interpolate_property(self, "modulate",
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "position",
		Vector2(position.x, position.y), Vector2(position.x, position.y-50), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _process(delta):
	if update_time:
		$Label.text = text_only + " " + "%.3f" % $Timer.get_time_left()
