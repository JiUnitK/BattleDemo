extends Node

var battle_scene = preload("res://scenes/battle/Battle.tscn")
var deck_scene = preload("res://scenes/deck/Deck.tscn")

var current_scene

func _ready():
	randomize()
	current_scene = deck_scene.instance()
	$World.add_child(current_scene)

func change_scene(scene):
	current_scene.queue_free()
	$World.remove_child(current_scene)

	if scene == "battle":
		print("battle scene")
		current_scene = battle_scene.instance()
		$World.add_child(current_scene)
	elif scene == "deck":
		current_scene = deck_scene.instance()
		$World.add_child(current_scene)
