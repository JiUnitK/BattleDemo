extends Node

signal player_key(key)

# Called when the node enters the scene tree for the first time.
func _ready():
	var _var = connect("player_key", 
			get_node("/root/Main/World/Battle/Hand"), 
			"_on_player_key")

func _input(event):
	if event.is_action_pressed("ui_right"):
		emit_signal("player_key", "right")
	if event.is_action_pressed("ui_left"):
		emit_signal("player_key", "left")
	if event.is_action_pressed("ui_accept"):
		emit_signal("player_key", "accept")
