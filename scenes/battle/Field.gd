extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")

var field_cards = []
var field_turns = []
var field_effects = "none"

var status = {}

signal return_to_deck(card)

func progressTime():
	# Progress field effects
	print(field_cards.size())
	for i in range(field_cards.size()-1, -1, -1):
		field_turns[i] -= 1
		if field_turns[i] == 0:
			# Invoke effect
			var effect = field_cards[i].invoke()
			if effect == "defend":
				field_effects = "defend"
			
			emit_signal("return_to_deck", field_cards[i])
			remove_child(field_cards[i])
			field_turns.pop_at(i)
			field_cards.pop_at(i)

func play(card):
	field_cards.push_front(card)
	field_turns.push_front(card.get_turns())
	add_child(card)
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
	status[card] = "none"
	card.position = getRandomPosOffset(30, 30)
	card.showCharacter()

func _on_enemy_attack(value):
	for card in status:
		if field_effects == "defend":
			card.change_hp(-1)
		else:
			card.change_hp(value)
