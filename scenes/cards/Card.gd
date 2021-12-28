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

func invoke():
	invokeConcrete()
	turn += 1
	
func _ready():
	readyConcrete()
	hp = hp_max
	reset()
	refreshHP()

func reset():
	turn = 1
	$Card.visible = true

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

func changeHP(value):
	$EffectText.flashText(value)
	hp += value
	if hp <= 0:
		hp = 0
		if not dead:
			dead = true
			emit_signal("card_effect", "death", id, card_name)
	elif hp > hp_max:
		hp = hp_max
	refreshHP()
		
func showCharacter():
	$Card.visible = false
	
func setID(new_id):
	id = new_id
