# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 1

func flashTextConcrete(value):
	$EffectText.flashText(value)
