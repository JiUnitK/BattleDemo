# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var hero_blue = preload("res://scenes/actors/heroes/CharBlue.tscn").instance()
var hero_yellow = preload("res://scenes/actors/heroes/CharYellow.tscn").instance()
var hero_current

var defend_up = false

signal hero_death(hero)

func _ready():
	if randi() % 2:
		hero_current = hero_blue
	else:
		hero_current = hero_yellow
	add_child(hero_current)
	hero_current.connect("hero_death", self, "_on_hero_death")

func _on_enemy_attack(value):
	if defend_up:
		hero_current._on_hp_change(-1)
	else:
		hero_current._on_hp_change(value)

func _on_swap_hero(hero):
	var target_hero
	if hero == "blue" and hero_current != hero_blue:
		target_hero = hero_blue
	elif hero == "yellow" and hero_current != hero_yellow:
		target_hero = hero_yellow
	else:
		return
	
	hero_current.disconnect("hero_death", self, "_on_hero_death")
	remove_child(hero_current)
	hero_current = target_hero
	add_child(hero_current)
	hero_current.connect("hero_death", self, "_on_hero_death")

func _on_hero_death(hero):
	emit_signal("hero_death", hero)
	if hero == "blue" and hero_current == hero_blue:
		_on_swap_hero("yellow")
	elif hero == "yellow" and hero_current == hero_yellow:
		_on_swap_hero("blue")
	
func _on_defend(time):
	defend_up = true
	$DefendTimer.start(time)
	$EffectText.flashText("defend up")

func _on_defend_timeout():
	defend_up = false
