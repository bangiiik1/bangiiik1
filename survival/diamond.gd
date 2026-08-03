extends StaticBody2D
func onhit():
	queue_free()
	game.additem("diamondore",1)
