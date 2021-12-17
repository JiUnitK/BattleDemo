# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var hero_blue = preload("res://scenes/actors/heroes/CharBlue.tscn").instance()
var hero_yellow = preload("res://scenes/actors/heroes/CharYellow.tscn").instance()
var effect_text = preload("res://scenes/battle/EffectText.tscn")

var hero_current
var defend_up = false

var hero_history = []
var heroes_alive = []

signal hero_death(hero)
signal no_more_heroes

func _ready():
	hero_history.push_back(hero_blue)
	hero_history.push_back(hero_yellow)
	
	hero_current = hero_history.pop_at(randi() % hero_history.size())
	add_child(hero_current)
	hero_current.connect("hero_death", self, "_on_hero_death")
	

func _on_hp_change(value):	
	if defend_up:
		value = -1
	
	hero_current._on_hp_change(value)
	
	var text = effect_text.instance()
	add_child(text)
	text.flashText(str(value))

func _on_hero_swap(hero):
	var target_hero
	if hero == "blue" and hero_current != hero_blue:
		target_hero = hero_blue
	elif hero == "yellow" and hero_current != hero_yellow:
		target_hero = hero_yellow
	else:
		return
	
	hero_history.push_front(hero_current)
	if hero_history.size() > 1:
		hero_history.pop_back()
	
	swap_hero(target_hero)
	
func swap_hero(target_hero):	
	hero_current.disconnect("hero_death", self, "_on_hero_death")
	remove_child(hero_current)
	hero_current = target_hero
	add_child(hero_current)
	hero_current.connect("hero_death", self, "_on_hero_death")

func _on_hero_death(hero):
	emit_signal("hero_death", hero)
	if hero_history.size() > 0:
		swap_hero(hero_history.pop_front())
	else:
		emit_signal("no_more_heroes")
	
func _on_defend(time):
	var text = effect_text.instance()
	add_child(text)
	text.flashText("defend up", true)
	defend_up = true
	$DefendTimer.start(time)

func _on_defend_timeout():
	defend_up = false
