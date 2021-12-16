extends Node2D

var hp = 1000
var hp_max = 1000

signal enqueue_action(name, steps)
signal enemy_attack(value)

func refreshHP():
	$HP.text = str(hp) + "/" + str(hp_max)
	
func startRandomTimer():
	if randi() % 2:
		emit_signal("enqueue_action", "RedEnemy", $HeavyAttackTimer.wait_time)
		$HeavyAttackTimer.start()
	else:
		emit_signal("enqueue_action", "RedEnemy", $NormalAttackTimer.wait_time)
		$NormalAttackTimer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	var _var = connect("enqueue_action", get_node("/root/Main/World/Battle/HUD/Timeline"), "_on_enqueue_action")
	_var = connect("enemy_attack", get_node("/root/Main/World/Battle/Hero"), "_on_enemy_attack")
	randomize()
	startRandomTimer()

func _on_NormalAttackTimer_timeout():
	emit_signal("enemy_attack", -50)	
	startRandomTimer()

func _on_HeavyAttackTimer_timeout():
	emit_signal("enemy_attack", -100)	
	startRandomTimer()
	
func _on_hp_change(value):
	hp += value
	if hp <= 0:
		hp = 0
	elif hp > hp_max:
		hp = hp_max
	refreshHP()
