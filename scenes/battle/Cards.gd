# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$Field.connect("return_to_deck", self, "_on_return_to_deck")
	
#	# Start with 3 cards in first hand and play left-most card
	$Hand.insert($Deck.draw())
	$Hand.insert($Deck.draw())
	$Hand.insert($Deck.draw())

func draw():
	if $Hand.getSize() < 5:
		$Hand.insert($Deck.draw())	
		
func _on_return_to_deck(card):
	$Deck.put_on_bottom(card)
	
func play(pos):
	if pos >= 0:
		$Field.play($Hand.removeSelection(), pos)
		$Field/Crosshair.moveTo(-1)

func highlightFieldPos(mouse_coord):
	var closest_idx = -1
	var char_width_halved = 100
	var char_height_halved = 100
	for i in 3:
		var x = $Field.global_position.x + $Field.x_offset * i
		var y = $Field.global_position.y + $Field.y_offset * i
		if abs(mouse_coord.x - x) < char_width_halved and abs(mouse_coord.y - y) < char_height_halved:
			closest_idx = i
			break
	$Field/Crosshair.moveTo(closest_idx)
	for i in $Field.field_cards.size():
		if $Field.field_cards[i] is Card:
			if i == closest_idx and closest_idx >= 0:
				$Field.field_cards[i].get_node("Description").visible = true
			elif $Field.field_cards[i] is Card:
				$Field.field_cards[i].get_node("Description").visible = false

func handleMouseHover(card_sel_locked):
	var mouse_coord = get_viewport().get_mouse_position()
	if card_sel_locked:
		highlightFieldPos(mouse_coord)
	else:
		var card_height_halved = 129
		
		if mouse_coord.y > $Hand.global_position.y - card_height_halved:
			if $Hand.cards.size() <= 0:
				return
				
			# Get center of every card in hand. 
			# Then determine selection to closest card by horizontal distance	
			var closest_sel = 0
			var closest_dist = 99999
			for i in $Hand.cards.size():
				var dist = abs($Hand.cards[i].global_position.x - mouse_coord.x)
				if dist < closest_dist:
					closest_dist = dist
					closest_sel = i
			if closest_dist > card_height_halved:
				$Hand.setSelection(-1)
			else:
				$Hand.setSelection(closest_sel)
		else:
			$Hand.setSelection(-1)
			highlightFieldPos(mouse_coord)
