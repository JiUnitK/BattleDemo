extends Sprite

var pos = -1

func moveTo(new_pos):
	pos = new_pos
	if pos >= 0:
		position.x = pos * 100
		position.y = pos * -150
		visible = true
	else:
		visible = false	
