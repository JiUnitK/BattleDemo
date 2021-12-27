# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 5
	priority = 2
	card_name = "bomber"

func invokeConcrete():
	if turn == 2:
		emit_signal("card_effect", "damage_all", -5, card_name)
