# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

var atk = 4
var effect_turn = 2

func readyConcrete():
	hp_max = 20
	$Description.text = "Hit " + str(atk) + "\nTurn " + str(effect_turn)

func invokeConcrete():
	if turn == effect_turn:
		emit_signal("card_effect", "damage_enemy", -atk, card_name)
