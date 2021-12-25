extends Node2D

var health = 3

signal no_player_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_hit():
	health -= 1
	if health == 3:
		$Heart1.visible = true
		$Heart2.visible = true
		$Heart3.visible = true
	elif health == 2:
		$Heart1.visible = true
		$Heart2.visible = true
		$Heart3.visible = false
	elif health == 1:
		$Heart1.visible = true
		$Heart2.visible = false
		$Heart3.visible = false
	else:
		$Heart1.visible = false
		$Heart2.visible = false
		$Heart3.visible = false
		emit_signal("no_player_health")
