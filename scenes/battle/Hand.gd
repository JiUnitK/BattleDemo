extends Node2D

var cards = []
var selection = 0

func setPositions():
	if selection > cards.size() - 1:
		selection = cards.size() - 1
	if selection < 0:
		selection = 0
		
	var mid = (cards.size()-1) / 2.0
	for i in cards.size():
		cards[i].position = Vector2(200, 0) * (i - mid)
			
	if cards.size() > 0:
		cards[selection].position += Vector2(0, -50)
		cards[selection].get_node("Description").visible = true

func insert(card):
	if card != null:
		cards.push_back(card)
		add_child(card)
		setPositions()

func getSize():
	return cards.size()
	
func getSelection():
	return cards[selection]

func moveSelection(dir):
	cards[selection].get_node("Description").visible = false
	if dir == "left" and selection > 0:
		selection -= 1
		setPositions()
	elif dir == "right" and selection < cards.size()-1:
		selection += 1
		setPositions()
	else:
		cards[selection].get_node("Description").visible = true

func removeSelection():
	if cards.size() > 0:
		var card = cards.pop_at(selection)
		remove_child(card)
		setPositions()
		return card
		
