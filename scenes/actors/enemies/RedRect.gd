extends Node2D

var hp = 30
var hp_max = 30

var targets = []
var damage = -3

signal enemy_attack(targets, value)
signal enemy_dead
signal enemy_intent(targets)

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)
	
func start():
	targets.clear()
	targets.push_back(randi() % 3)
	emit_signal("enemy_intent", targets)
		
func progressTime():
	emit_signal("enemy_attack", targets, damage)
	start()

func _on_hp_change(value):
	$EffectText.flashText(str(value))
	hp += value
	if hp <= 0:
		hp = 0
		emit_signal("enemy_dead")
	elif hp > hp_max:
		hp = hp_max
	refreshHP()
