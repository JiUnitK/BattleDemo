extends Node

var is_pause_enabled = true

func _input(event):
	if event.is_action_pressed("ui_cancel") and is_pause_enabled:
		get_tree().paused = not get_tree().paused

func enable_pause_control(on):
	is_pause_enabled = on
