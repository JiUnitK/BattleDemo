# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D
	
var enable_player_action = true
	
func _ready():
#	$Heroes.connect("hero_death", self, "_on_hero_death")
#	$Heroes.connect("no_more_heroes", self, "_on_no_more_heroes")
	$Enemy/RedRect.connect("enemy_attack", self, "_on_enemy_attack")
	$Enemy/RedRect.connect("enemy_dead", self, "_on_enemy_dead")
	$PlayerHealth.connect("no_player_health", self, "_on_no_player_health")
	
	$Enemy/RedRect.start()
			
func _input(event):
	if event.is_action_pressed("ui_right") and enable_player_action:
		$Cards/Hand.moveSelection("right")
	if event.is_action_pressed("ui_left") and enable_player_action:
		$Cards/Hand.moveSelection("left")
	if event.is_action_pressed("ui_accept") and enable_player_action:
		$Cards.play()	
	if event.is_action_pressed("ui_advance_time"):
		enable_player_action = false
		
		# Order is extremely important. Hero goes first. Then enemy. Then cards are drawn
		$Cards/Field.progressTime()
		$Timer.start()
		
func _on_hero_death(name):
	$Hand._on_hero_death(name)
	
func _on_enemy_attack(value):
	if not $Cards/Field.damage_cards(value):
		$PlayerHealth.take_hit()

func _on_no_player_health():
	$HUD/GameOver.visible = true
	$PauseControl.enable_pause_control(false)
	get_tree().paused = true
	
func _on_enemy_dead():
	$HUD/GameOver.visible = true
	$PauseControl.enable_pause_control(false)
	get_tree().paused = true

var timer_stage = 0
func _on_Timer_timeout():
	if timer_stage == 0:
		$Enemy/RedRect.progressTime()
		timer_stage += 1
		$Timer.start()
	elif timer_stage == 1:
		$Cards/Field.resolveWithdraw()
		timer_stage += 1
		$Timer.start()
	else:
		$Cards.draw()
		enable_player_action = true
		timer_stage = 0
