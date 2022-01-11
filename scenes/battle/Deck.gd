extends Node

var card_shield = preload("res://scenes/cards/CardShield.tscn")
var card_sword = preload("res://scenes/cards/CardSword.tscn")
var card_duck = preload("res://scenes/cards/CardDuck.tscn")
var card_collector = preload("res://scenes/cards/CardCollector.tscn")
var card_medic = preload("res://scenes/cards/CardMedic.tscn")
var card_bomber = preload("res://scenes/cards/CardBomber.tscn")
var card_archer = preload("res://scenes/cards/CardArcher.tscn")
var card_withdraw = preload("res://scenes/cards/CardWithdraw.tscn")

var deck = []

func load_deck():
	var file = File.new()
	if file.open("res://data/default_deck.json", file.READ) != OK:
		return
	var text = file.get_as_text()
	file.close()
	var data_parse = JSON.parse(text)
	if data_parse.error != OK:
		return
	return data_parse.result

# Called when the node enters the scene tree for the first time.
func _ready():
	var unshuffled_deck = []
	var saved_deck_dict = load_deck()
	for i in saved_deck_dict["characters"]:
		if i["equip"] > 0:
			# Match the equipment to the thing
			for j in saved_deck_dict["equipment"]:
				if (i["equip"] == j["id"]):
					var card
					if j["type"] == "sword":
						card = card_sword.instance()
					elif j["type"] == "shield":
						card = card_shield.instance()
					elif j["type"] == "duck":
						card = card_duck.instance()
					elif j["type"] == "collector":
						card = card_collector.instance()
					elif j["type"] == "medic":
						card = card_medic.instance()
					elif j["type"] == "bomber":
						card = card_bomber.instance()
					elif j["type"] == "archer":
						card = card_archer.instance()
					elif j["type"] == "withdraw":
						card = card_withdraw.instance()
					card.setID(i["id"])
					unshuffled_deck.push_back(card)
					break
		
	# Shuffle deck
	for i in unshuffled_deck.size():
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
	
