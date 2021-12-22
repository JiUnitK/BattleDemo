# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

class_name CardYellow

var hp = 100
var hp_max = 100
var dead = false

signal hero_death(hero)
signal damage_enemy(value)

func _ready():
	connect("damage_enemy", get_node("/root/GlobalSignalRouter"), "_on_damage_enemy")
	refreshHP()

func invoke():
	emit_signal("damage_enemy", -100)

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
			emit_signal("hero_death", "yellow")
	elif hp > hp_max:
		hp = hp_max
	refreshHP()
	
func get_hero_name():
	return "yellow"
	
func showCharacter():
	$Card.visible = false
	$Character.visible = true
	$HP.visible = true
	
func showCard():
	$Card.visible = true
	$Character.visible = false
	$HP.visible = false
