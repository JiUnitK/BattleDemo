# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var effect_text = preload("res://scenes/battle/EffectText.tscn")

var field_cards = []
var defend = 0

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
			if field_cards[i] != null and field_cards[i].priority == current_priority:
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
		card.position.x = pos * 100
		card.position.y = pos * -150
		card.get_node("Card").visible = false
		card.get_node("Character").visible = true
		card.get_node("Description").visible = false
	else:
		# Need to put withdraw card back to deck
		emit_signal("return_to_deck", field_cards[pos])

func damage_cards(damage):
	var cards_on_field = false
	for i in field_cards:
		if i is Card:
			cards_on_field = true
	if not cards_on_field:
		return false
	
	var damage_temp = damage
	damage += defend
	defend += damage_temp
	if damage > 0:
		damage = 0
	else:
		defend = 0
		$Defend.visible = false
	$Defend.text = "Defend " + str(defend)
			
	for card in field_cards:
		if card is Card:
			card.changeHP(damage)
	return true

func _on_card_effect(effect, value, _source_str):
	if effect == "defend":
		defend += value
		$Defend.text = "Defend " + str(defend)
		$Defend.visible = true
	elif effect == "damage_enemy":
		emit_signal("damage_enemy", value)
	elif effect == "damage_all":
		emit_signal("damage_enemy", value)
		damage_cards(value)
	elif effect == "heal_party":
		damage_cards(value)
	elif effect == "death":
		for i in field_cards.size():
			if field_cards[i] != null and field_cards[i].id == value:
				removeCard(i)
				break

func MoveCrosshair(dir, any_pos):
	if $Crosshair.pos >= 0 and field_cards[$Crosshair.pos] is Card:
		field_cards[$Crosshair.pos].get_node("Description").visible = false
		
	if dir == "up":
		if any_pos:
			$Crosshair.moveTo($Crosshair.pos+1)
		else:
			for i in range($Crosshair.pos+1, field_cards.size()):
				if field_cards[i] is Card:
					$Crosshair.moveTo(i)
					break
	else:
		if any_pos:
			$Crosshair.moveTo($Crosshair.pos-1)
		else:
			var found_lower_card = false
			for i in range($Crosshair.pos-1, -1, -1):
				if field_cards[i] is Card:
					found_lower_card = true
					$Crosshair.moveTo(i)
					break
			if not found_lower_card:
				$Crosshair.moveTo(-1)
	
	print("pos = " + str($Crosshair.pos))
	if $Crosshair.pos > 0 and field_cards[$Crosshair.pos] is Card:
		print("make visible")
		field_cards[$Crosshair.pos].get_node("Description").visible = true
