extends Label

func _process(delta: float) -> void:
	text = "здоровье: " + str(game.hp)
