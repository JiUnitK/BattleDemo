# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

var defend = 5
var effect_turn = 1

func readyConcrete():
	hp_max = 5
	priority = 1
	card_name = "shield"
	$Description.text = "Defend " + str(defend) + "\nTurn " + str(effect_turn)

func invokeConcrete():
	if turn == effect_turn:
		emit_signal("card_effect", "defend", 5, "")
