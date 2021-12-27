# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 5
	priority = 1
	card_name = "shield"

func invokeConcrete():
	if turn == 1:
		emit_signal("card_effect", "defend", 5, "")
	else:
		emit_signal("card_effect", "remove_defend", 5, "")

func flashTextConcrete(value):
	$EffectText.flashText(value)
