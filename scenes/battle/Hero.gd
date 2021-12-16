extends Node2D

var hero_blue = preload("res://scenes/actors/heroes/CharBlue.tscn").instance()
var hero_yellow = preload("res://scenes/actors/heroes/CharYellow.tscn").instance()
var hero_current

var defend_up = false

signal hp_change(value)

func _ready():
	randomize()
	if randi() % 2:
		hero_current = hero_blue
	else:
		hero_current = hero_yellow
	add_child(hero_current)
	var _var = connect("hp_change", hero_current, "_on_hp_change")

func _on_enemy_attack(value):
	if defend_up:
		emit_signal("hp_change", -1)
	else:
		emit_signal("hp_change", value)

func _on_swap_hero(hero):
	if hero == "blue" and hero_current != hero_blue:
		disconnect("hp_change", hero_current, "_on_hp_change")
		remove_child(hero_current)
		hero_current = hero_blue
		add_child(hero_current)
		var _var = connect("hp_change", hero_current, "_on_hp_change")
	elif hero == "yellow" and hero_current != hero_yellow:
		disconnect("hp_change", hero_current, "_on_hp_change")
		remove_child(hero_current)
		hero_current = hero_yellow
		add_child(hero_current)
		var _var = connect("hp_change", hero_current, "_on_hp_change")

func _on_hero_death(hero):
	if hero == "blue" and hero_current == hero_blue:
		_on_swap_hero("yellow")
	elif hero == "yellow" and hero_current == hero_yellow:
		_on_swap_hero("blue")
	
func _on_defend(time):
	$DefendTimer.start(time)
	defend_up = true
	$EffectText.setText("defend up")

func _on_defend_timer_timeout():
	defend_up = false
	print("defend expire")
