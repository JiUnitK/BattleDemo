# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Sprite

class_name CardBlue

signal hero_swap(target)
signal hero_defend(time_s)

func _ready():
	connect("hero_swap", get_node("/root/GlobalSignalRouter"), "_on_hero_swap")
	connect("hero_defend", get_node("/root/GlobalSignalRouter"), "_on_hero_defend")

func invoke():
	emit_signal("hero_swap", "blue")
	emit_signal("hero_defend", 1)
