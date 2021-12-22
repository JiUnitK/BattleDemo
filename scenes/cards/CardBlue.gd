# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name CardBlue

var hp = 200
var hp_max = 200
var dead = false

signal hero_death(hero)
signal hero_defend(time_s)

func _ready():
	connect("hero_defend", get_node("/root/GlobalSignalRouter"), "_on_hero_defend")
	refreshHP()

func invoke():
	emit_signal("hero_defend", 1)

func get_turns():
	return 1

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

func _on_hp_change(value):
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
