extends Panel
var slots
func _ready() -> void:
	slots = get_node("hbox").get_children()
	for i in range(slots.size()):
		slots[i].pressed.connect(_on_slot_pressed.bind(i))
func _on_slot_pressed(i):
	var slot = game.inventory[i]
	if !slot:
		return
	if slot["name"] == "campfire" && slot["count"] >= 1:
		game.buildmode = true
		game.building = "campfire"
	if slot["name"] == "berry" && slot["count"] >= 1:
		game.food = clamp(game.food+3,0,100)
		game.additem("berry", -1)
	if slot["name"] == "cookedmeat" && slot["count"] >= 1:
		game.food = clamp(game.food+20,0,100)
		game.additem("cookedmeat", -1)
	if slot["name"] == "woodenwall" && slot["count"] >= 1:
		game.buildmode = true
		game.building = "woodenwall"
	if slot["name"] == "workbench" && slot["count"] >= 1:
		game.buildmode = true
		game.building = "workbench"
