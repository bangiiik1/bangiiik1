extends CharacterBody2D
@export var speed = 300
var colliding = {}
var colliding2 = {}
var oncd = false

func _physics_process(delta: float) -> void:
	game.plrpos = position
	if game.hp<= 0:
		queue_free()
		game.hp = 0
	var direction = Vector2.ZERO
	if Input.is_action_pressed("w"):
		direction.y -= 1
	if Input.is_action_pressed("s"):
		direction.y += 1
	if Input.is_action_pressed("d"):
		direction.x += 1
	if Input.is_action_pressed("a"):
		direction.x -= 1
	direction = direction.normalized()
	velocity = direction*speed
	look_at(get_global_mouse_position())
	move_and_slide()
	for body in colliding2.keys():
		if body.is_in_group("wolf"):
			game.hp -= 1
		if body.is_in_group("bear"):
			game.hp -= 3
		
	if oncd == false && Input.is_action_pressed("lmb"):
		var focused = get_viewport().gui_get_hovered_control()
		if focused != null and not focused.is_in_group("notui"):
			return
		oncd = true
		if colliding != {}:
			for i in colliding.size():
				if colliding.keys()[i].is_in_group("tree"):
					game.additem("wood",1)
					colliding.keys()[i].onhit()
				if colliding.keys()[i].is_in_group("wolf"):
					colliding.keys()[i].dmg()
				if colliding.keys()[i].is_in_group("bear"):
					colliding.keys()[i].dmg()
				if colliding.keys()[i].is_in_group("bush"):
					colliding.keys()[i].mineres()
				if colliding.keys()[i].is_in_group("wall"):
					colliding.keys()[i].onhit()
				if colliding.keys()[i].is_in_group("workbench"):
					colliding.keys()[i].onhit()
				if colliding.keys()[i].is_in_group("stone") && game.tools[0] != "hand":
					colliding.keys()[i].onhit()
				if colliding.keys()[i].is_in_group("diamond") && game.tools[0] == "stonepickaxe":
					colliding.keys()[i].onhit()
	if game.buildmode:
		if Input.is_action_just_pressed("e"):
			if game.building == "campfire":
				game.additem("campfire",-1)
				var koster = preload("res://fire.tscn").instantiate()
				koster.position = position+Vector2(60,0).rotated(rotation)
				koster.get_children()[0].play()
				get_parent().add_child(koster)
				game.buildmode = false
			if game.building == "woodenwall":
				game.additem("woodenwall",-1)
				var wall = preload("res://woodenwall.tscn").instantiate()
				wall.position = position+Vector2(60,0).rotated(rotation)
				get_parent().add_child(wall)
				game.buildmode = false
			if game.building == "workbench":
				game.additem("workbench",-1)
				var wall = preload("res://workbench.tscn").instantiate()
				wall.position = position+Vector2(60,0).rotated(rotation)
				get_parent().add_child(wall)
				game.buildmode = false
		if Input.is_action_just_pressed("q"):
			game.buildmode = false
	var new_biome = position.x >= 2500
	if game.isinwinter != new_biome:
		game.isinwinter = new_biome
func _on_area_2d_body_entered(body: Node2D) -> void:
	colliding[body] = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	colliding.erase(body)


func _on_minecd_timeout() -> void:
	oncd = false


func _on_plrarea_body_entered(body: Node2D) -> void:
	colliding2[body] = true


func _on_plrarea_body_exited(body: Node2D) -> void:
	colliding2.erase(body)
