extends Panel
func _ready():
	hide()
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("f"):
		visible = not visible



func _on_campfire_button_down() -> void:
	if game.getitem("wood") >= 15:
		game.additem("wood",-15)
		game.additem("campfire", 1)


func _on_wall_pressed() -> void:
	if game.getitem("wood") >= 12:
		game.additem("wood",-12)
		game.additem("woodenwall", 1)


func _on_cookmeat_pressed() -> void:
	if game.getitem("rawmeat") >= 1 && game.nearfire:
		game.additem("rawmeat",-1)
		game.additem("cookedmeat", 1)


func _on_pickaxe_pressed() -> void:
	if game.tools[0] == "hand" && game.nearworkbench:
		if game.getitem("wood") >= 25:
			game.additem("wood",-25)
			game.tools[0] = "woodenpickaxe"
			get_parent().get_node("tool").updtools()
			$VBoxContainer/pickaxe.text = "кирка из 15 дерева и 20 камня (нужен верстак)"
	if game.tools[0] == "woodenpickaxe" && game.nearworkbench:
		if game.getitem("wood") >= 15 && game.getitem("stoneore") >= 20:
			game.additem("wood",-15)
			game.additem("stone", -20)
			game.tools[0] = "stonepickaxe"
			get_parent().get_node("tool").updtools()
			$VBoxContainer/pickaxe.queue_free()


func _on_workbench_pressed() -> void:
	if game.getitem("wood") >= 30:
		game.additem("wood",-30)
		game.additem("workbench",1)


func _on_shapka_pressed() -> void:
	if game.getitem("wolffur") >= 8 && !game.isinshapka && game.nearworkbench:
		game.additem("wolffur",-8)
		game.isinshapka = true
		game.updskin()
