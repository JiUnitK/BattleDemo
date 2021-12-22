extends Node

func _ready():
	pass # Replace with function body.
	
func _on_damage_enemy(value):
	get_node("/root/Main/World/Battle/Enemy/RedRect")._on_hp_change(value)
