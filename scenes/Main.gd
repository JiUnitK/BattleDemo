extends Node

var battle_scene = preload("res://scenes/battle/Battle.tscn")
var deck_scene = preload("res://scenes/deck/Deck.tscn")
var start_screen_scene = preload("res://scenes/StartScreen.tscn")

var current_scene

func _ready():
	randomize()
	current_scene = start_screen_scene.instance()
	$World.add_child(current_scene)

func change_scene(scene):
	current_scene.queue_free()
	$World.remove_child(current_scene)

	if scene == "battle":
		current_scene = battle_scene.instance()
		$World.add_child(current_scene)
	elif scene == "deck":
		current_scene = deck_scene.instance()
		$World.add_child(current_scene)
	elif scene == "start":
		current_scene = start_screen_scene.instance()
		$World.add_child(current_scene)
