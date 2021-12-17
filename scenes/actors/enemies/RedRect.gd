extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")

var hp = 1000
var hp_max = 1000

signal enemy_schedules_attack(steps)
signal enemy_attack(value)
signal enemy_dead

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)
	
func startRandomTimer():
	if randi() % 2:
		emit_signal("enemy_schedules_attack", $HeavyAttackTimer.wait_time)
		$HeavyAttackTimer.start()
	else:
		emit_signal("enemy_schedules_attack", $NormalAttackTimer.wait_time)
		$NormalAttackTimer.start()

func _on_NormalAttackTimer_timeout():
	emit_signal("enemy_attack", -50)	
	startRandomTimer()

func _on_HeavyAttackTimer_timeout():
	emit_signal("enemy_attack", -100)	
	startRandomTimer()
	
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
