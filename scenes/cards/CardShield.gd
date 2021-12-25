# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name CardShield

var hp = 200
var hp_max = 200
var dead = false

var turns = 3
var turn = turns

signal hero_death(hero)
signal card_effect(effect, value)

func _ready():
	refreshHP()

func reset():
	turn = turns
	$Card.visible = true
	$Turn.visible = false

func invoke():
	turn -= 1
	$Turn.text = str(turn)
	emit_signal("card_effect", "defend", 0)
	return turn

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

func change_hp(value):
	hp += value
	if hp <= 0:
		hp = 0
		if not dead:
			dead = true
			emit_signal("hero_death", "card_shield")
	elif hp > hp_max:
		hp = hp_max
	refreshHP()

func get_hero_name():
	return "card_shield"
	
func showCharacter():
	$Card.visible = false
	$Turn.visible = true