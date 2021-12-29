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
		
func setSelection(pos):
	for i in cards.size():
		cards[i].position.y = 0
		if i == pos:
			cards[i].position.y = -50
	if pos != selection:
		cards[selection].get_node("Description").visible = false
	if pos >= 0:	
		cards[pos].get_node("Description").visible = true
	selection = pos
		
