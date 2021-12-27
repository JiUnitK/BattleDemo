# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 10
	priority = 2
	card_name = "sword"

func invokeConcrete():
	emit_signal("card_effect", "damage_enemy", -1, card_name)
