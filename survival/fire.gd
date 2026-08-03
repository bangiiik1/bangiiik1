extends Area2D

var touchplr = false
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		touchplr = false
		game.nearfire = false
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		touchplr = true
		game.nearfire = true


func _on_timer_timeout() -> void:
	if touchplr:
		game.temp = clamp(game.temp + 1,0,100)
