# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 2
	priority = 2
	card_name = "collector"

func invokeConcrete():
	return

func flashTextConcrete(value):
	$EffectText.flashText(value)
