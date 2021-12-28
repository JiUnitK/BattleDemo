# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D
	
var enable_player_action = true
	
func _ready():
	$Enemy/RedRect.connect("enemy_attack", self, "_on_enemy_attack")
	$Enemy/RedRect.connect("enemy_dead", self, "_on_enemy_dead")
	$PlayerHealth.connect("no_player_health", self, "_on_no_player_health")
	
	$Enemy/RedRect.start()

var selecting_pos = false
func _input(event):
	if enable_player_action:
		if not selecting_pos:
			# Selecting card
			if event.is_action_pressed("ui_right"):
				$Cards/Hand.moveSelection("right")
			if event.is_action_pressed("ui_left"):
				$Cards/Hand.moveSelection("left")
			if event.is_action_pressed("ui_up"):
				$Cards/Field.MoveCrosshair("up", false)
			if event.is_action_pressed("ui_down"):
				$Cards/Field.MoveCrosshair("down", false)
			if event.is_action_pressed("ui_accept"):
				$Cards/Field/Crosshair.moveTo(0)
				if $Cards/Hand.getSize() > 0:
					selecting_pos = true
				else:
					# no cards in hand. Just advance time
					progressTime()
			if event.is_action_pressed("ui_advance_time"):
				progressTime()
		else:
			# Selecting field position to summon card
			if event.is_action_pressed("ui_up"):
				$Cards/Field.MoveCrosshair("up", true)
			if event.is_action_pressed("ui_down"):
				$Cards/Field.MoveCrosshair("false", true)
			if event.is_action_pressed("ui_accept"):
				$Cards.play($Cards/Field/Crosshair.pos)
				selecting_pos = false
			if event.is_action_pressed("ui_back"):
				$Cards/Field/Crosshair.moveTo(-1)
				selecting_pos = false

func progressTime():
	enable_player_action = false
			
	# Order is extremely important. Hero goes first. Then enemy. Then cards are drawn
	$Cards/Field.progressTime()
	$Timer.start()

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
	else:
		$Cards.draw()
		enable_player_action = true
		timer_stage = 0
