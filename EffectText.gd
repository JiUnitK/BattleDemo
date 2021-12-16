extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _on_Timer_timeout():
	visible = false

func setText(message):
	visible = true
	$Label.text = message
	$Timer.start(1)
	
