# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Sprite

class_name CardYellow

signal hero_swap(target)
signal damage_enemy(value)

func _ready():
	connect("hero_swap", get_node("/root/GlobalSignalRouter"), "_on_hero_swap")
	connect("damage_enemy", get_node("/root/GlobalSignalRouter"), "_on_damage_enemy")

func invoke():
	emit_signal("hero_swap", "yellow")
	emit_signal("damage_enemy", -100)
