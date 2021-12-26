# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp = 20
	hp_max = 20
	turns = 3
	turn = turns
	card_name = "shield"

func invokeConcrete():
	if turn <= 0:
		emit_signal("card_effect", "damage_enemy", -100, "")
