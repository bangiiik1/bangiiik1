extends Node
var hp = 100
var temp = 100
var food = 100
var buildmode = false
var building = ""
var plrpos = Vector2.ZERO
var nearfire = false
var nearworkbench = false
var isinshapka = false
var isinwinter = false
var tools = [
	"hand",
	"hand"
]
var inventory = [
	null,null,null,null,null,null,null,null,null,null
	]

func _on_timer_timeout() -> void:
	if !game.nearfire:
		game.temp -= 3
		if game.isinshapka:
			game.temp += 1
		if game.isinwinter:
			game.temp -= 2
		if game.temp <= 0:
			game.temp = 0
			game.hp -= 3
	game.food -= 1
	if game.food <= 0:
		game.food = 0
		game.hp -= 3
	if game.temp >= 80 && game.food >=70:
		game.hp = clamp(game.hp+1,0,100)
func upd_inventory():
	var slots = get_parent().get_node("main/ui/Panel/hbox").get_children()
	for i in range(slots.size()):
		var texture = slots[i].get_node("texture")
		if game.inventory[i] == null:
			texture.hide()
			slots[i].get_node("amout").hide()
		else:
			texture.show()
			slots[i].get_node("amout").show()
			texture.texture = load("res://" + game.inventory[i]["name"] + ".png")
			slots[i].get_node("amout").text = str(game.inventory[i]["count"])

func organize_inventory():
	for i in range(game.inventory.size()):
		if game.inventory[i] == null:
			continue
		if game.inventory[i]["count"] <= 0:
			game.inventory[i] = null
func getitem(something: String):
	for slot in game.inventory:
		if slot == null:
			continue
		if slot["name"] == something:
			return slot["count"]
			break
	return 0
	organize_inventory()
	upd_inventory()
func additem(something: String, number: int):
	var some = false
	for i in range(game.inventory.size()):
		if game.inventory[i] && game.inventory[i]["name"] == something:
			game.inventory[i]["count"] += number
			some = true
			break
	if !some:
		for i in range(game.inventory.size()):
			if game.inventory[i] != null:
				continue
			else:
				game.inventory[i] = {"name": something, "count": number}
				break
				return
	organize_inventory()
	upd_inventory()
func updskin():
	if game.isinshapka:
		get_parent().get_node("main/player/Sprite2D").texture = load("res://shapka.png")
