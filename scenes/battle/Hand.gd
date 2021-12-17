extends Node2D

var card_blue = preload("res://scenes/cards/CardBlue.tscn")
var card_yellow = preload("res://scenes/cards/CardYellow.tscn")

var hand = []
var selection = 0

func setHandPositions():
	if selection > hand.size() - 1:
		selection = hand.size() - 1
	if selection < 0:
		selection = 0
		
	var mid = (hand.size()-1) / 2.0
	for i in hand.size():
		hand[i].position = Vector2(200, 0) * (i - mid)
			
	if hand.size() > 0:
		hand[selection].position += Vector2(0, -50)

# Called when the node enters the scene tree for the first time.
func _ready():
#	# Start with 2 cards in first hand
	hand.push_back($Deck.draw())
	hand.push_back($Deck.draw())
#
	add_child(hand[0])
	add_child(hand[1])
	setHandPositions()

func _on_Timer_timeout():
	# Draw a card
	if hand.size() < 5 and not $Deck.is_empty():
		hand.push_back($Deck.draw())
		add_child(hand.back())
		setHandPositions()
	
func _on_player_key(key):
	if key == "left" and selection > 0:
		selection -= 1
	elif key == "right" and selection < hand.size()-1:
		selection += 1
	elif key == "accept":
		if hand.size() > 0:
			# Invoke card effect
			hand[selection].invoke()
			
			# Return card to deck
			remove_child(hand[selection])
			$Deck.put_on_bottom(hand.pop_at(selection))
	setHandPositions()
	
func _on_hero_death(hero):
	# Remove all cards associated with hero
	var card_class
	if hero == "yellow":
		card_class = CardYellow
	else:
		card_class = CardBlue
		
	$Deck.removeClass(card_class)
	
	for i in range(hand.size()-1, -1, -1):
		if hand[i] is card_class:
			remove_child(hand[i])
			hand.pop_at(i).queue_free()
	setHandPositions()
