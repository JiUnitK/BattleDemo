extends Node

var scene = preload("res://scenes/battle/Battle.tscn").instance()

func _ready():
	randomize()
	$World.add_child(scene)

