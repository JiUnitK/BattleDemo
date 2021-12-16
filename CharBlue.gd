extends Node2D

var hp = 500
var hp_max = 500

signal death(hero)

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

# Called when the node enters the scene tree for the first time.
func _ready():
	var _var = connect("death", get_node("/root/Battle/Hand"), "_on_hero_death")
	_var = connect("death", get_node("/root/Battle/Hero"), "_on_hero_death")
	refreshHP()

func _on_hp_change(value):
	hp += value
	if hp <= 0:
		hp = 0
		emit_signal("death", "blue")
	elif hp > hp_max:
		hp = hp_max
	refreshHP()
