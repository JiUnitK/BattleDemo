# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")
var intent = preload("res://scenes/battle/Intent.tscn")

var field_cards = []

var x_offset = 100
var y_offset = -150

signal return_to_deck(card)
signal damage_enemy(value)

func _ready():
	# Create array of 3 positions
	for x in 3:
		field_cards.push_back(null)
			
	connect("damage_enemy", get_node("/root/GlobalSignalRouter"), "_on_damage_enemy")

func progressTime():
	for i in range(field_cards.size()-1, -1, -1):
		if field_cards[i] != null:
			field_cards[i].invoke()

func removeCard(pos):
	if field_cards[pos] is Card:
		field_cards[pos].disconnect("card_effect", self, "_on_card_effect")
		field_cards[pos].reset()
		remove_child(field_cards[pos])
		field_cards[pos] = null
		if $Crosshair.pos == pos:
			$Crosshair.visible = false
			$Crosshair.moveTo(-1)

func play(card, pos):
	if field_cards[pos] is Card:
		var old_card = field_cards[pos]
		removeCard(pos)
		emit_signal("return_to_deck", old_card)
	if card.card_name != "withdraw":
		# summon new character
		add_child(card)
		field_cards[pos] = card
		card.connect("card_effect", self, "_on_card_effect")
		card.position.x = pos * x_offset
		card.position.y = pos * y_offset
		card.get_node("Card").visible = false
		card.get_node("Character").visible = true
		card.get_node("Description").visible = false
	else:
		# Need to put withdraw card back to deck
		emit_signal("return_to_deck", field_cards[pos])

func damage_card(target, damage):
	if field_cards[target] == null:
		return
				
	field_cards[target].damage(damage)
	
func heal_card(target, value):
	if field_cards[target] == null:
		return
	field_cards[target].changeHP(value)
	
func _on_card_effect(effect, value, _source_str):
	if effect == "damage_enemy":
		emit_signal("damage_enemy", value)
	elif effect == "damage_all":
		emit_signal("damage_enemy", value)
		for i in 3:
			if field_cards[i] is Card:
				field_cards[i].damage(value)
	elif effect == "heal_party":
		for i in 3:
			if field_cards[i] is Card:
				field_cards[i].damage(value)
	elif effect == "death":
		for i in field_cards.size():
			if field_cards[i] != null and field_cards[i].id == value:
				removeCard(i)
				break

var intents = []
func highlightIntent(targets):
	for it in intents:
		remove_child(it)
	intents.clear()
	
	for it in targets:
		var instance = intent.instance()
		intents.push_back(instance)
		add_child(instance)
		instance.position.x = x_offset * it
		instance.position.y = y_offset * it
		instance.playing = true
		
		
