# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name Card

var id = 0
var hp = 1
var hp_max = 1
var dead = false
var card_name = "none"

var turn = 1
var priority = 1

signal card_effect(effect, value, source_str)

# Override in child function with meaningful behavior
func readyConcrete():
	return

func invokeConcrete():
	return
	
func flashTextConcrete(_value):
	return

func getPriority():
	return priority

func invoke():
	invokeConcrete()
	turn += 1
	$Turn.text = str(turn)

func _ready():
	readyConcrete()
	hp = hp_max
	reset()
	refreshHP()

func reset():
	turn = 1
	$Turn.text = str(turn)
	$Card.visible = true
	$Turn.visible = false

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

func change_hp(value):
	flashTextConcrete(value)
	hp += value
	if hp <= 0:
		hp = 0
		if not dead:
			dead = true
			emit_signal("card_effect", "death", 0, card_name)
	elif hp > hp_max:
		hp = hp_max
	refreshHP()

func get_hero_name():
	return card_name
		
func showCharacter():
	$Card.visible = false
	$Turn.visible = true
	
func getID():
	return id
	
func setID(new_id):
	id = new_id
