extends Node

var scene = preload("res://scenes/battle/Battle.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	$World.add_child(scene)

