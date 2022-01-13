# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

var card_shield = preload("res://scenes/cards/CardShield.tscn")
var card_sword = preload("res://scenes/cards/CardSword.tscn")
var card_duck = preload("res://scenes/cards/CardDuck.tscn")
var card_collector = preload("res://scenes/cards/CardCollector.tscn")
var card_medic = preload("res://scenes/cards/CardMedic.tscn")
var card_bomber = preload("res://scenes/cards/CardBomber.tscn")
var card_archer = preload("res://scenes/cards/CardArcher.tscn")
var card_withdraw = preload("res://scenes/cards/CardWithdraw.tscn")

var deck = []
var cards = []
var spare_equipment = []
var card_spacing = Vector2(250, 300)
var CARDS_PER_ROW = 4

var card_selected = false
var selected_card = 0

var saved_deck_dict

# signal deck_exit

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

func _ready():
	$ExitButton.connect("button_up", get_node("/root/GlobalSignalRouter"), "_on_deck_exit")

	$Equipment.text = ""
	saved_deck_dict = load_deck()
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
					card.id = i["id"]
					card.card_name = i["name"]
					card.base_hp = i["hp"]
					card.base_atk = i["atk"]
					card.equip = i["equip"]
					card.card_class = i["class"]
					deck.push_back(card)
					break
	
	for i in deck:
		insert(i)
		
	setPositions()

func insert(card):
	cards.push_back(card)
	add_child(card)

func setPositions():
	for i in cards.size():
		var row = i / CARDS_PER_ROW
		var col = i % CARDS_PER_ROW
		cards[i].position.x = card_spacing.x * col + (card_spacing.x / 2)
		cards[i].position.y = card_spacing.y * row + (card_spacing.y / 2)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var pos = get_viewport().get_mouse_position()
		if pos.x < (card_spacing.x * CARDS_PER_ROW):
			
			# Get column of selection
			var closest_dist = 9999
			var closest_col = 0
			for i in CARDS_PER_ROW:
				var dist = abs(pos.x - (card_spacing.x * i + card_spacing.x/2))
				if dist < closest_dist:
					closest_dist = dist
					closest_col = i

			# Get row of selection
			closest_dist = 9999
			var closest_row = 0
			for i in (cards.size() / CARDS_PER_ROW + 1):
				var dist = abs(pos.y - (card_spacing.y * i + card_spacing.y/2))
				if dist < closest_dist:
					closest_dist = dist
					closest_row = i

			var picked_card = closest_row * CARDS_PER_ROW + closest_col
			if picked_card != selected_card:
				selected_card = picked_card
				$Equipment.visible = false
				spare_equipment = []
			$Crosshair.position.x = closest_col * card_spacing.x + card_spacing.x/2
			$Crosshair.position.y = closest_row * card_spacing.y + card_spacing.y/2
			$Crosshair.visible = true
			
			$Description.text = deck[selected_card].card_name
			if deck[selected_card].card_class == "human":
				var equip_type = "None"
				if deck[selected_card].equip != 0:
					for i in saved_deck_dict["equipment"]:
						if i["id"] == deck[selected_card].equip:
							equip_type = i["type"]


				$Description.text += "\nStats\n  HP: " \
				+ str(deck[selected_card].base_hp) \
				+ "\n  Atk: " \
				+ str(deck[selected_card].base_atk) \
				+ "\n\nEquip:\n  " \
				+ equip_type
		elif pos.y > 344 and pos.y < 400 and deck[selected_card].card_class == "human":
			for i in saved_deck_dict["equipment"]:
				if i["character"] == 0:
					$Equipment.text += i["type"] + "\n"
					spare_equipment.push_back(i["id"])
			$Equipment.visible = true
		elif pos.y > 483 and $Equipment.visible:
			var vertical_spacing = 48
			var y_dist = pos.y - 483
			var index = int(y_dist / vertical_spacing)
			if index > spare_equipment.size() - 1:
				index = spare_equipment.size() - 1
			saved_deck_dict["characters"][selected_card].equip = spare_equipment[index]
			saved_deck_dict["equipment"][index].character = saved_deck_dict["characters"][selected_card].id

			print(saved_deck_dict["equipment"][index].character)
			print(saved_deck_dict["characters"][selected_card].equip)
			var file = File.new()
			file.open("res://data/saved_deck.json", File.READ_WRITE)
			file.store_line(to_json(saved_deck_dict))
			file.close()			

# func _process(delta):
# 	var pos = get_viewport().get_mouse_position()
# 	print(str(pos.x) + ", " + str(pos.y))
