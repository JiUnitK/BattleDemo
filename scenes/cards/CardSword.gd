# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name CardSword

var hp = 100
var hp_max = 100
var dead = false

var turns = 2
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
	if turn <= 0:
		emit_signal("card_effect", "damage_enemy", -100)
	return turn

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)
	
func change_hp(value):
	hp += value
	if hp <= 0:
		hp = 0
		if not dead:
			dead = true
			emit_signal("hero_death", "card_sword")
	elif hp > hp_max:
		hp = hp_max
	refreshHP()
	
func get_hero_name():
	return "card_sword"
	
func showCharacter():
	$Card.visible = false
	$Turn.visible = true
