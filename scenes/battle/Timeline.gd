extends ColorRect

var steps_total = 10

func _process(delta):
	var vel = Vector2(-1, 0) * get_size().x/steps_total
	$EnemyAvatar.position += vel * delta
		
func _on_enqueue_action(name, steps):
	if name == "RedEnemy":
		$EnemyAvatar.visible = true
		$EnemyAvatar.position = Vector2(get_size().x * steps / steps_total , get_size().y/2)	
