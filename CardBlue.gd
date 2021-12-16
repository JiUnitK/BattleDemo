extends Sprite

class_name CardBlue

signal swap_hero(target)
signal defend(time)

func _ready():
	var _var = connect("swap_hero", get_node("/root/Battle/Hero"), "_on_swap_hero")
	_var = connect("defend", get_node("/root/Battle/Hero"), "_on_defend")

func invoke():
	emit_signal("swap_hero", "blue")
	emit_signal("defend", 1)
