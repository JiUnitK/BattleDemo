# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")

var field_cards = []
var field_effects = "none"

signal return_to_deck(card)
signal damage_enemy(value)

func _ready():
	connect("damage_enemy", get_node("/root/GlobalSignalRouter"), "_on_damage_enemy")

func progressTime():
	# Progress field effects
	for i in range(field_cards.size()-1, -1, -1):
		var turn = field_cards[i].invoke()
		if turn <= 0:
			emit_signal("return_to_deck", field_cards[i])
			field_cards[i].showCard()
			remove_child(field_cards[i])
			field_cards.pop_at(i)

func play(card):
	field_cards.push_front(card)
	add_child(card)
	card.connect("card_effect", self, "_on_card_effect")
	summon(card)

func getRandomPosOffset(x, y):
	var rand_offset = Vector2(0, 0)

	var offset = randi() % x
	if randi() % 2:	
		offset = -offset
		rand_offset.x += offset

	offset = randi() % y
	if randi() % 2:	
		offset = -offset
	rand_offset.y += offset

	return rand_offset
	
func summon(card):
	card.position = getRandomPosOffset(60, 60)
	card.showCharacter()

func _on_enemy_attack(value):
	for card in field_cards:
		if field_effects == "defend":
			card.change_hp(-1)
		else:
			card.change_hp(value)

func _on_card_effect(effect, value):
	if effect == "defend":
		field_effects = "defend"
	elif effect == "damage_enemy":
		emit_signal("damage_enemy", value)
