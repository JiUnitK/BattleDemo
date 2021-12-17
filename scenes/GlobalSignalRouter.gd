extends Node

func _ready():
	pass # Replace with function body.
	
func _on_hero_swap(name):
	get_node("/root/Main/World/Battle/Hero")._on_hero_swap(name)

func _on_hero_defend(time_s):
	get_node("/root/Main/World/Battle/Hero")._on_defend(time_s)

func _on_damage_enemy(value):
	get_node("/root/Main/World/Battle/Enemy/RedRect")._on_hp_change(value)
