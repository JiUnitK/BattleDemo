# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name CardBlue

var hp = 200
var hp_max = 200
var dead = false

signal hero_death(hero)

func _ready():
	refreshHP()

func invoke():
	return "defend"

func get_turns():
	return 1

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

func change_hp(value):
	hp += value
	if hp <= 0:
		hp = 0
		if not dead:
			dead = true
			emit_signal("hero_death", "blue")
	elif hp > hp_max:
		hp = hp_max
	refreshHP()

func get_hero_name():
	return "BLUE"
	
func showCharacter():
	$Card.visible = false
	$Character.visible = true
	$HP.visible = true
	
func showCard():
	$Card.visible = true
	$Character.visible = false
	$HP.visible = false
