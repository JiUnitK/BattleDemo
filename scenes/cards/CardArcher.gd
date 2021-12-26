# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

func readyConcrete():
	hp_max = 20
	turn_max = 3
	priority = 2
	card_name = "archer"

func invokeConcrete():
	if turn <= 0:
		emit_signal("card_effect", "damage_enemy", -4, card_name)

func flashTextConcrete(value):
	$EffectText.flashText(value)

