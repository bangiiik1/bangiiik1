extends CharacterBody2D

@export var speed: float = 200.0
@export var hp: int = 7
var plr
var see = 0
var curdir = 0
var angry = false
func dmg():
	$Sprite2D.modulate = Color(1,0.7,0.7)
	hp -= 1
	$timer.start()
func _ready() -> void:
	plr = get_parent().get_node("player")
func seeplr():
	var ray = $RayCast2D
	ray.target_position = to_local(plr.global_position)
	ray.force_raycast_update()
	if ray.get_collider() == plr:
		return true
	else:
		return false
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	if !angry:
		rotation = curdir
	if position.distance_to(plr.position) <= 400 && seeplr():
		angry = true
		see = 2
	if angry:
		look_at(plr.position)
		if position.distance_to(plr.position) > 400 || !seeplr():
			see -= delta
		if see <= 0:
			angry = false
	direction = Vector2.from_angle(rotation)
	velocity = direction * speed
	move_and_slide()


func _on_timer_timeout() -> void:
	$Sprite2D.modulate = Color(1,1,1)
	if hp <= 0:
		game.additem("rawmeat",1)
		game.additem("wolffur",1)
		queue_free()


func _on_walktimer_timeout() -> void:
	if !angry:
		curdir = randf() * 2 * PI
