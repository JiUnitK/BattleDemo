extends Node2D

var hp = 100
var hp_max = 100
var dead = false

signal hero_death(hero)

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)

# Called when the node enters the scene tree for the first time.
func _ready():
	refreshHP()

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
