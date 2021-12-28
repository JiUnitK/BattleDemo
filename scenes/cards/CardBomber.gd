# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

var effect_turn = 2
var atk = 5

func readyConcrete():
	hp_max = 5
	priority = 2
	card_name = "bomber"
	$Description.text = "Hit all " + str(atk) + "\nTurn " + str(effect_turn)
	
func invokeConcrete():
	if turn == effect_turn:
		emit_signal("card_effect", "damage_all", -atk, card_name)
