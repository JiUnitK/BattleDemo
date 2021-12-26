extends Node

var card_shield = preload("res://scenes/cards/CardShield.tscn")
var card_sword = preload("res://scenes/cards/CardSword.tscn")
var card_duck = preload("res://scenes/cards/CardDuck.tscn")
var card_collector = preload("res://scenes/cards/CardCollector.tscn")
var card_medic = preload("res://scenes/cards/CardMedic.tscn")
var card_bomber = preload("res://scenes/cards/CardBomber.tscn")
var card_archer = preload("res://scenes/cards/CardArcher.tscn")

var deck = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var unshuffled_deck = []
	unshuffled_deck.push_back(card_shield.instance())
	unshuffled_deck.push_back(card_sword.instance())
	unshuffled_deck.push_back(card_duck.instance())
	unshuffled_deck.push_back(card_collector.instance())
	unshuffled_deck.push_back(card_medic.instance())
	unshuffled_deck.push_back(card_bomber.instance())
	unshuffled_deck.push_back(card_archer.instance())
		
	# Shuffle deck
	for i in 7:
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
	
