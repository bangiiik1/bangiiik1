extends StaticBody2D
@export var iskill = false
@export var checkpoint = false
@export var instantkill = false
@export var bounce = 0
var touchingplr = false
func _ready() -> void:
	if iskill:
		$Sprite2D.modulate = Color(1,0,0)
	if checkpoint:
		$Sprite2D.modulate = Color(0,1,0)
	if instantkill:
		$Sprite2D.modulate = Color(0.3,0.3,0.3)
	if bounce != 0:
		$Sprite2D.modulate = Color(1,1,0)

func _process(delta: float) -> void:
	if touchingplr and iskill:
		game.hp -= 2
	if touchingplr and instantkill:
		game.hp = -1


func _on_touch_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		touchingplr = true
		if checkpoint:
			game.checkpoint = global_position + Vector2(0,-0.1)
			game.hp = 100
			$checkpoint.position = position
			$checkpoint.emitting = true
			await get_tree().create_timer(0.1).timeout
			$checkpoint.emitting = false


func _on_touch_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		touchingplr = false
