extends StaticBody2D
func onhit():
	scale = Vector2(0.95,0.95)
	$timer.start()

func _on_timer_timeout() -> void:
	scale = Vector2(1,1)
