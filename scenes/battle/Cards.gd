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

func handleMouseHover():
	var mouse_coord = get_viewport().get_mouse_position()
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
	
