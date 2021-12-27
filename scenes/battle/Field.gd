# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")

var field_cards = []
var defend_sources = {}

signal return_to_deck(card)
signal damage_enemy(value)

func _ready():
	# Create array of 3 positions
	for x in 3:
		field_cards.push_back(null)
			
	connect("damage_enemy", get_node("/root/GlobalSignalRouter"), "_on_damage_enemy")

func progressTime():
	# Progress field effects in order of priority
	for current_priority in 3:
		for i in range(field_cards.size()-1, -1, -1):
			if field_cards[i] != null and field_cards[i].getPriority() == current_priority:
				field_cards[i].invoke()

func play(card, pos):
	if field_cards[pos] is Card:
		# Withdraw current character at position
		field_cards[pos].disconnect("card_effect", self, "_on_card_effect")
		emit_signal("return_to_deck", field_cards[pos])
		field_cards[pos].reset()
		remove_child(field_cards[pos])
	if card.getName() != "withdraw":
		# summon new character
		add_child(card)
		field_cards[pos] = card
		card.connect("card_effect", self, "_on_card_effect")
		card.position.x = pos * 100
		card.position.y = pos * -150
		card.showCharacter()

func damage_cards(value):
	var cards_on_field = false
	for i in field_cards:
		if i is Card:
			cards_on_field = true
	if not cards_on_field:
		return false
	
	var defend_sum = 0
	for i in defend_sources.values():
		defend_sum += i
		
	if value < 0:
		value += defend_sum
		if value > 0:
			value = 0
			
	for card in field_cards:
		if card is Card:
			card.changeHP(value)
	return true

func _on_card_effect(effect, value, source_str):
	if effect == "defend":
		defend_sources[source_str] = value
	elif effect == "remove_defend":
		defend_sources.erase(source_str)
	elif effect == "damage_enemy":
		emit_signal("damage_enemy", value)
	elif effect == "damage_all":
		emit_signal("damage_enemy", value)
		damage_cards(value)
	elif effect == "heal_party":
		damage_cards(value)
