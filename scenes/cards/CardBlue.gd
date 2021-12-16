extends Sprite

class_name CardBlue

signal swap_hero(target)
signal defend(time)

func invoke():
	emit_signal("swap_hero", "blue")
	emit_signal("defend", 1)
