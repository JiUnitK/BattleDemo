# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

var effect_turn = 1

func readyConcrete():
	hp_max = 5
	defend_max = 3
	defend = defend_max
	$Description.text = "Defend " + str(defend) + "\nTurn " + str(effect_turn)

func resetConcrete():
	defend = defend_max

func invokeConcrete():
	if turn == effect_turn:
		emit_signal("card_effect", "defend", 5, "")
