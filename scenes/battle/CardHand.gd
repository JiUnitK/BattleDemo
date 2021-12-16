extends Node2D

var card_blue = preload("res://CardBlue.tscn")
var card_yellow = preload("res://CardYellow.tscn")

var deck = []
var hand = []
var selection = 0

func setHandPositions():
	if selection > hand.size() - 1:
		selection = hand.size() - 1
	if selection < 0:
		selection = 0
		
	if hand.size() % 2:
		# odd
		var mid = hand.size() / 2
		for i in hand.size():
				hand[i].position = Vector2(200, 0) * (i - mid)
	else:
		#even
		var mid = (hand.size()-1) / 2.0
		for i in hand.size():
			hand[i].position = Vector2(200, 0) * (i - mid)
			
	if hand.size() > 0:
		hand[selection].position += Vector2(0, -50)

# Called when the node enters the scene tree for the first time.
func _ready():
	var unshuffled_deck = []
	for i in 5:
		unshuffled_deck.push_back(card_blue.instance())
		unshuffled_deck.push_back(card_yellow.instance())
		
	# Shuffle deck of 5 random attack and 5 random defend
	randomize()
	for i in 10:
		deck.push_back(unshuffled_deck.pop_at(randi() % unshuffled_deck.size()))
		
#	# Start with 2 cards in first hand
	hand.push_back(deck.pop_front())
	hand.push_back(deck.pop_front())
#
	add_child(hand[0])
	add_child(hand[1])
	setHandPositions()

func _on_Timer_timeout():
	if hand.size() < 5:
		hand.push_back(deck.pop_front())
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
			deck.push_back(hand.pop_at(selection))
	setHandPositions()
	
func _on_hero_death(hero):
	if hero == "yellow":
		print("yellow died")
		for i in deck.size():
			if deck[i] == card_yellow:
				deck.pop_at(i)
		for i in hand.size():
			if hand[i] == card_yellow:
				print("found yellow card in hand")
				remove_child(hand[i])
				hand.pop_at(i)
	elif hero == "blue":
		print("blue died")
		for i in deck.size():
			if deck[i] == card_blue:
				deck.pop_at(i)
		for i in hand.size():
			if hand[i] == card_blue:
				remove_child(hand[i])
				hand.pop_at(i)
	setHandPositions()
		
