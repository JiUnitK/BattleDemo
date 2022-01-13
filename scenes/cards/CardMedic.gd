# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

var heal = 2
var effect_turn = 2

func readyConcrete():
	hp_max = 1
	$Description.text = "Heal party " + str(heal) + "\nTurn " + str(effect_turn)

func invokeConcrete():
	if turn == effect_turn:
		emit_signal("card_effect", "heal_party", heal, "")
