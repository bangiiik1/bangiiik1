extends Label

func _process(delta: float) -> void:
	text = "тепло: " + str(game.temp)
