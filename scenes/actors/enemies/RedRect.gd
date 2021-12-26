extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")

var hp = 30
var hp_max = 30

var heavy_attack_turns = 3
var normal_attack_turns = 2
var countdown = 0
var action_queue = ""
var action_queue_heavy_atk = "heavy_attack"
var action_queue_normal_atk = "normal_attack"

signal enemy_attack(value)
signal enemy_dead

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)
	
func start():
	if randi() % 2:
		countdown = heavy_attack_turns
		action_queue = action_queue_heavy_atk
	else:
		countdown = normal_attack_turns
		action_queue = action_queue_normal_atk
	$TurnsToAction.text = str(countdown)
		
func progressTime():
	if countdown <= 0:
		return
	
	countdown -= 1
	if countdown == 0:
		if action_queue == action_queue_normal_atk:
			emit_signal("enemy_attack", -2)
			start()
		else:
			emit_signal("enemy_attack", -5)	
			start()
	else:
		$TurnsToAction.text = str(countdown)

func _on_hp_change(value):
	var text = effect_text.instance()
	add_child(text)
	text.flashText(str(value))
	
	hp += value
	if hp <= 0:
		hp = 0
		emit_signal("enemy_dead")
	elif hp > hp_max:
		hp = hp_max
		
	refreshHP()
