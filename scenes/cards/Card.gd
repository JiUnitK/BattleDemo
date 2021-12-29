# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name Card

var defend = 0
var defend_max = 0
var id = 0
var hp = 1
var hp_max = 1
var dead = false
var card_name = "none"

var turn = 1

signal card_effect(effect, value, source_str)

# Override in child function with meaningful behavior
func readyConcrete():
	return
	
func invokeConcrete():
	return
	
func flashTextConcrete(_value):
	return

func resetConcrete():
	return

func invoke():
	invokeConcrete()
	turn += 1
	
func _ready():
	readyConcrete()
	hp = hp_max
	reset()

func reset():
	resetConcrete()
	defend = defend_max
	turn = 1
	$Card.visible = true
	refreshHP()

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)
	if defend > 0:
		$HP.text += "\nDefend " + str(defend)

func damage(value):
	if value < 0:
		if abs(value) > defend:
			value += defend
			defend = 0
		else:
			defend += value
			value = 0


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
