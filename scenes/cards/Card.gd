# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name Card

var hp = 1
var hp_max = 1
var dead = false
var card_name = "archer"

var turns = 1
var turn = turns

signal card_effect(effect, value, source_str)

# Override in child function with meaningful behavior
func readyConcrete():
	return

func invokeConcrete():
	return

func invoke():
	turn -= 1
	$Turn.text = str(turn)
	invokeConcrete()
	return turn

func _ready():
	readyConcrete()
	$Turn.text = str(turn)
	refreshHP()

func reset():
	turn = turns
	$Card.visible = true
	$Turn.visible = false

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

func change_hp(value):
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
