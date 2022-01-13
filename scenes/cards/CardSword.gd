# warning-ignore-all:RETURN_VALUE_DISCARDED
extends "res://scenes/cards/Card.gd"

var atk = 1

func readyConcrete():
	hp_max = 3
	$Description.text = "Hit " + str(atk) + "\nEvery turn"
	
func invokeConcrete():
	emit_signal("card_effect", "damage_enemy", -atk, card_name)
