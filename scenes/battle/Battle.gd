# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D
	
func _ready():
	$Hero.connect("hero_death", self, "_on_hero_death")
	$Hero.connect("no_more_heroes", self, "_on_no_more_heroes")
	$Enemy/RedRect.connect("enemy_schedules_attack", self, "_on_enemy_schedules_attack")
	$Enemy/RedRect.connect("enemy_attack", self, "_on_enemy_attack")
	$Enemy/RedRect.connect("enemy_dead", self, "_on_enemy_dead")
	
	$Enemy/RedRect.startRandomTimer()
			
func _input(event):
	if event.is_action_pressed("ui_right"):
		$Hand._on_player_key("right")
	if event.is_action_pressed("ui_left"):
		$Hand._on_player_key("left")
	if event.is_action_pressed("ui_accept"):
		$Hand._on_player_key("accept")	
		
func _on_hero_death(name):
	$Hand._on_hero_death(name)
	
func _on_enemy_schedules_attack(steps):
	$HUD/Timeline._on_enemy_schedules_attack(steps)

func _on_enemy_attack(value):
	$Hero._on_hp_change(value)

func _on_no_more_heroes():
	$HUD/GameOver.visible = true
	$PauseControl.enable_pause_control(false)
	get_tree().paused = true
	
func _on_enemy_dead():
	$HUD/GameOver.visible = true
	$PauseControl.enable_pause_control(false)
	get_tree().paused = true
