extends CharacterBody2D
var speed = 30
var frc = 0.98
var maxspd = 200
var gravity = 8
var jumpower = 300

func jump():
	velocity.y = -jumpower
	$particles.emitting = true
	await get_tree().create_timer(0.01).timeout
	$particles.emitting = false

func _physics_process(delta: float) -> void:
	game.hp += 0.02
	game.hp = clamp(game.hp,0,100)
	if game.hp <= 0 or position.y > 700:
		global_position = game.checkpoint
		game.hp = 100
	$hp.value = game.hp
	$hp.get_theme_stylebox("fill").bg_color = Color.from_hsv((game.hp/360)*1.2,1,1)
	if game.hp == 100:
		$hp.get_theme_stylebox("fill").bg_color = Color.LIME
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if abs(velocity.x) < maxspd:
		velocity += Vector2(direction*speed,0)
	velocity.x *= frc
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			if get_last_slide_collision().get_collider().bounce == 0:
				jump()
		if is_on_wall_only():
			var col = get_last_slide_collision()
			if col:
				if get_last_slide_collision().get_normal().x < 0:
					velocity.x -= jumpower*1.3
				else:
					velocity.x += jumpower*1.3
				velocity.y = -jumpower
	velocity.y += gravity
	move_and_slide()
	var col = get_last_slide_collision()
	if col and col.get_collider().bounce != 0:
		velocity += col.get_normal() * col.get_collider().bounce
