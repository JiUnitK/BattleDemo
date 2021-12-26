extends Node2D

var update_time = false
var text_only = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_Timer_timeout():
	visible = false

func flashText(message):	
	visible = true
	$Label.text = str(message)
	$Timer.start(1)
	
	$Tween.interpolate_property(self, "modulate",
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "position",
		Vector2(position.x, position.y), Vector2(position.x, position.y-50), 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
