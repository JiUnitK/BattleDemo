# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D
	
func _ready():
	$Hero.connect("hero_death", self, "_on_hero_death")
	$Enemy1/RedRect.connect("enemy_schedules_attack", self, "_on_enemy_schedules_attack")
	$Enemy1/RedRect.connect("enemy_attack", self, "_on_enemy_attack")
	$Hand.connect("swap_hero", self, "_on_swap_hero")
	$Hand.connect("defend", self, "_on_defend")
	
	$Enemy1/RedRect.startRandomTimer()
			
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
	$Hero._on_enemy_attack(value)

func _on_swap_hero(target):
	$Hero._on_swap_hero(target)
	
func _on_defend(time):
	$Hero._on_defend(time)
