extends Sprite

class_name CardYellow

signal swap_hero(target)

func _ready():
	var _var = connect("swap_hero", get_node("/root/Battle/Hero"), "_on_swap_hero")

func invoke():
	emit_signal("swap_hero", "yellow")
