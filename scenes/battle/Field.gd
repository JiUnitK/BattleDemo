# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")

var field_cards = []
var field_effects = "none"

var position_taken = []

signal return_to_deck(card)
signal damage_enemy(value)

func _ready():
	# Create 3x3 array
	for x in 3:
		position_taken.push_back([])
		for y in 3: 
			position_taken[x].push_back(null)
			
	connect("damage_enemy", get_node("/root/GlobalSignalRouter"), "_on_damage_enemy")

func progressTime():
	# Progress field effects
	for i in range(field_cards.size()-1, -1, -1):
		var turn = field_cards[i].invoke()
		if turn <= 0:
			emit_signal("return_to_deck", field_cards[i])
			field_cards[i].reset()
			for x in position_taken.size():
				for y in position_taken[x].size():
					if position_taken[x][y] == field_cards[i]:
						position_taken[x][y] = null
			
			remove_child(field_cards[i])
			field_cards.pop_at(i)

func play(card):
	field_cards.push_front(card)
	add_child(card)
	card.connect("card_effect", self, "_on_card_effect")
	summon(card)

func getRandomUnusedPos():
	var empty_pos_stack = []
	for x in 3:
		for y in 3:
			if position_taken[x][y] == null:
					empty_pos_stack.push_back(Vector2(x, y))
	
	var rand_idx = randi() % empty_pos_stack.size()
	return empty_pos_stack[rand_idx]
		
	
func summon(card):
	var empty_pos = getRandomUnusedPos()
	position_taken[empty_pos.x][empty_pos.y] = card
	card.position.x = empty_pos.x * 150
	card.position.y = empty_pos.y * 150
	card.showCharacter()

func _on_enemy_attack(value):
	if field_cards.empty():
		return false
	
	for card in field_cards:
		if field_effects == "defend":
			card.change_hp(-1)
		else:
			card.change_hp(value)
	
	return true

func _on_card_effect(effect, value, _source_str):
	if effect == "defend":
		field_effects = "defend"
	elif effect == "damage_enemy":
		emit_signal("damage_enemy", value)
