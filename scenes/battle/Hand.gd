extends Node2D

var cards = []
var selection = -1
var card_spacing = Vector2(200, 0)

func setPositions():
	if selection > cards.size() - 1:
		selection = cards.size() - 1
	if selection < -1:
		selection = -1
		
	var mid = (cards.size()-1) / 2.0
	for i in cards.size():
		cards[i].position = card_spacing * (i - mid)

func insert(card):
	if card != null:
		cards.push_back(card)
		add_child(card)
		setPositions()

func getSize():
	return cards.size()

func removeSelection():
	if cards.size() > 0:
		var card = cards.pop_at(selection)
		remove_child(card)
		setPositions()
		return card

func handleMouseHover():
	var mouse_coord = get_viewport().get_mouse_position()
	
	var card_height_halved = 129
	if mouse_coord.y < global_position.y - card_height_halved:
		return
	
	if cards.size() <= 0:
		return
	
	# Get center of every card in hand. 
	# Then determine selection to closest card by horizontal distance	
	var closest_sel = 0
	var closest_dist = 99999
	for i in cards.size():
		var dist = abs(cards[i].global_position.x - mouse_coord.x)
		if dist < closest_dist:
			closest_dist = dist
			closest_sel = i
	if selection != closest_sel:
		cards[selection].global_position.y = global_position.y
		cards[selection].get_node("Description").visible = false
		selection = closest_sel
	cards[selection].global_position.y = global_position.y - 50
	cards[selection].get_node("Description").visible = true
