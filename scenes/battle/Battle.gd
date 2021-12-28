# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D
	
var enable_player_action = true
	
func _ready():
	$Enemy/RedRect.connect("enemy_attack", self, "_on_enemy_attack")
	$Enemy/RedRect.connect("enemy_dead", self, "_on_enemy_dead")
	$PlayerHealth.connect("no_player_health", self, "_on_no_player_health")
	
	$Enemy/RedRect.start()

func _input(event):
	if enable_player_action:
		if not $Cards/Field/SelectionArrow.visible:
			# Selecting card
			if event.is_action_pressed("ui_right"):
				$Cards/Hand.moveSelection("right")
			if event.is_action_pressed("ui_left"):
				$Cards/Hand.moveSelection("left")
			if event.is_action_pressed("ui_up"):
				$Cards/Field.MoveCrosshair("up")
			if event.is_action_pressed("ui_down"):
				$Cards/Field.MoveCrosshair("down")
			if event.is_action_pressed("ui_accept"):
				if $Cards/Hand.getSize() > 0:
					$Cards/Field/SelectionArrow.visible = true
				else:
					# no cards in hand. Just advance time
					progressTime()
			if event.is_action_pressed("ui_advance_time"):
				progressTime()
		else:
			# Selecting field position to summon card
			if event.is_action_pressed("ui_right"):
				$Cards/Field/SelectionArrow.move("right")
			if event.is_action_pressed("ui_left"):
				$Cards/Field/SelectionArrow.move("left")
			if event.is_action_pressed("ui_accept"):
				$Cards.play($Cards/Field/SelectionArrow.getPos())
				$Cards/Field/SelectionArrow.visible = false
			if event.is_action_pressed("ui_back"):
				$Cards/Field/SelectionArrow.visible = false

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
