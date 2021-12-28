# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D
	
var enable_player_action = true
var card_sel_locked = false
	
func _ready():
	$Enemy/RedRect.connect("enemy_attack", self, "_on_enemy_attack")
	$Enemy/RedRect.connect("enemy_dead", self, "_on_enemy_dead")
	$PlayerHealth.connect("no_player_health", self, "_on_no_player_health")
	
	$Enemy/RedRect.start()
	
func _process(_delta):
	$Cards.handleMouseHover(card_sel_locked)

func _input(event):
	if enable_player_action:
		if not card_sel_locked:
			# Selecting card
			if event.is_action_pressed("ui_accept"):
				$Cards/Field/Crosshair.moveTo(-1)
				if $Cards/Hand.selection >= 0 and $Cards/Hand.selection < $Cards/Hand.getSize():
					card_sel_locked = true
		else:
			# Selecting field position to summon card
			if event.is_action_pressed("ui_accept"):
				$Cards.play($Cards/Field/Crosshair.pos)
				card_sel_locked = false
			if event.is_action_pressed("ui_back"):
				$Cards/Field/Crosshair.moveTo(-1)
				card_sel_locked = false

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

func _on_EndTurn_button_up():
	$Cards/Field/Crosshair.moveTo(-1)
	card_sel_locked = false
	progressTime()
