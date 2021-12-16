extends Sprite

class_name CardYellow

signal swap_hero(target)

func invoke():
	emit_signal("swap_hero", "yellow")
