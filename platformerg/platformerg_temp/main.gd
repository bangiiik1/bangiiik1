extends Node2D


func _on_skiproute_pressed() -> void:
	$Label14.queue_free()
	$wall21.queue_free()
	$wall22.queue_free()
	$wall23.queue_free()
