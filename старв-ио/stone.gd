extends StaticBody2D
func onhit():
	game.additem("stoneore",1)
	scale = Vector2(1.4,1.4)
	$Timer.start()

func _on_timer_timeout() -> void:
	scale = Vector2(1.5,1.5)
