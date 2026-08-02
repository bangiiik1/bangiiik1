extends StaticBody2D
@export var res = 3
func setanim():
	$AnimatedSprite2D.play(str(res))
func mineres():
	if res < 1:
		return
	res -= 1
	game.additem("berry",1)
	setanim()


func _on_restoretimer_timeout() -> void:
	if res < 3:
		res += 1
		setanim()
