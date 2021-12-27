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
	
func _on_player_key(key):
	if key == "left":
		$Hand.moveSelection("left")
	elif key == "right":
		$Hand.moveSelection("right")
	elif key == "accept":
		$Hand.getSelection()
		
func play(pos):
	$Field.play($Hand.removeSelection(), pos)
	
#func _on_hero_death(hero):
#	# Remove all cards associated with hero
#	var card_class
#	if hero == "yellow":
#		card_class = CardYellow
#	else:
#		card_class = CardBlue
#
#	$Deck.removeClass(card_class)
#
#	for i in range(hand.size()-1, -1, -1):
#		if hand[i] is card_class:
#			remove_child(hand[i])
#			hand.pop_at(i).queue_free()
#	setHandPositions()
