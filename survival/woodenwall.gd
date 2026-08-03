extends StaticBody2D
var hp = 5
func onhit():
	hp -= 1
	if hp <= 0:
		game.additem("wood",7)
		queue_free()
		
