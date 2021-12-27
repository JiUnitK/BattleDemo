# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 1
	priority = 2
	card_name = "medic"

func invokeConcrete():
	if turn == 2:
		emit_signal("card_effect", "heal_party", 2, "")

func flashTextConcrete(value):
	$EffectText.flashText(value)
