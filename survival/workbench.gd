extends StaticBody2D
var hp = 3
func onhit():
	hp -= 1
	if hp <= 0:
		game.additem("wood",13)
		queue_free()
func _on_craftarea_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		game.nearworkbench = true


func _on_craftarea_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		game.nearworkbench = false
