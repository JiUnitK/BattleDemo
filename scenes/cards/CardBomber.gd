# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 5
	turn_max = 2
	priority = 2
	card_name = "bomber"

func invokeConcrete():
	if turn <= 0:
		emit_signal("card_effect", "damage_all", -5, card_name)

func flashTextConcrete(value):
	$EffectText.flashText(value)
