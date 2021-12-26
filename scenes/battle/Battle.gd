# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D
	
func _ready():
#	$Heroes.connect("hero_death", self, "_on_hero_death")
#	$Heroes.connect("no_more_heroes", self, "_on_no_more_heroes")
	$Enemy/RedRect.connect("enemy_attack", self, "_on_enemy_attack")
	$Enemy/RedRect.connect("enemy_dead", self, "_on_enemy_dead")
	$PlayerHealth.connect("no_player_health", self, "_on_no_player_health")
	
	$Enemy/RedRect.start()
			
func _input(event):
	if event.is_action_pressed("ui_right"):
		$Cards/Hand.moveSelection("right")
	if event.is_action_pressed("ui_left"):
		$Cards/Hand.moveSelection("left")
	if event.is_action_pressed("ui_accept"):
		$Cards.play()	
	if event.is_action_pressed("ui_advance_time"):
		# Order is extremely important. Hero goes first. Then enemy. Then cards are drawn
		$Cards.progressTime()
		$Enemy/RedRect.progressTime()
		
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
