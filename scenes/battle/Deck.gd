extends Node

var card_blue = preload("res://scenes/cards/CardBlue.tscn")
var card_yellow = preload("res://scenes/cards/CardYellow.tscn")

var deck = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var unshuffled_deck = []
	for i in 3:
		unshuffled_deck.push_back(card_blue.instance())		
		unshuffled_deck.push_back(card_yellow.instance())		
		
	# Shuffle deck of 3 attack and 3 defend
	for i in 6:
		deck.push_back(unshuffled_deck.pop_at(randi() % unshuffled_deck.size()))

func draw():
	return deck.pop_front()
	
func is_empty():
	return deck.empty()

func put_on_bottom(card):
	deck.push_back(card)
	
func removeClass(classType):
	for i in range(deck.size()-1, -1, -1):
		if deck[i] is classType:
			deck.pop_at(i).queue_free()
	
