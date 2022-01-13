extends Node

#var scene = preload("res://scenes/battle/Battle.tscn").instance()
var scene = preload("res://scenes/deck/Deck.tscn").instance()

func _ready():
	randomize()
	$World.add_child(scene)
