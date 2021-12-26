# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 1
	turn_max = 1
	priority = 2
	card_name = "duck"

func flashTextConcrete(value):
	$EffectText.flashText(value)
