extends Node

func _ready():
	pass # Replace with function body.
	
func _on_damage_enemy(value):
	get_node("/root/Main/World/Battle/Enemy/RedRect")._on_hp_change(value)

func _on_deck_exit():
	get_node("/root/Main").change_scene("battle")

func _on_change_scene(scene):
	get_node("/root/Main").change_scene(scene)
