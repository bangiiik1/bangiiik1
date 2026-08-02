extends GPUParticles2D
func _ready() -> void:
	process_material.emission_shape_scale.x = get_viewport_rect().size.x
	process_material.emission_shape_offset.x = get_viewport_rect().size.x/2
func _process(delta: float) -> void:
	if game.isinwinter:
		emitting = true
	else:
		emitting = false
