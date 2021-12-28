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
	if card == null:
		print("See? tried to put null into deck")
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
