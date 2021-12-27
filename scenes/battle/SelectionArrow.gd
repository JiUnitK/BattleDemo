extends Sprite

var pos = 0

func move(dir):
	if (dir == "left") and (pos > 0):
		pos -= 1
	elif (dir == "right") and (pos < 2):
		pos += 1
	position.x = pos * 100
	position.y = pos * -150 - 150

func getPos():
	return pos
