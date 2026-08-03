extends Node2D
var screen
var cam
func generateobjects(object: String,count:int):
	for i in count:
		var pscene = load("res://" + str(object) + ".tscn").instantiate()
		if object == "bush":
			pscene.position = Vector2(randf()*5000-2500, randf()*5000-2500)
		else:
			pscene.position = Vector2(randf_range(-2500,7500), randf()*5000-2500)
		if object == "diamond":
			pscene.position = Vector2(randf_range(2500,7500), randf()*5000-2500)
		add_child(pscene)
func _ready():
	cam = get_viewport().get_camera_2d().position
	screen = get_viewport_rect().size
	generateobjects("tree",100)
	generateobjects("bush",20)
	generateobjects("stone",60)
	generateobjects("diamond",10)
func spawnbear():
	var wolf = preload("res://bear.tscn").instantiate()
	var spawnpos = Vector2(randf_range(5000,10000),randf()*5000-2500)
	var left = cam.x - screen.x/2
	var right = cam.x + screen.x/2
	var top = cam.y - screen.y/2
	var bottom = cam.y + screen.y/2
	if !(spawnpos.x > right || spawnpos.x < left):
		spawnbear()
		return
	if !(spawnpos.y < top || spawnpos.y > bottom):
		spawnbear()
		return
	wolf.position = spawnpos
	print("bear spawned!ddd")
	add_child(wolf)
func spawnwolf():	
	var wolf = preload("res://wolf.tscn").instantiate()
	var spawnpos = Vector2(randf()*5000-2500,randf()*5000-2500)
	var left = cam.x - screen.x/2
	var right = cam.x + screen.x/2
	var top = cam.y - screen.y/2
	var bottom = cam.y + screen.y/2
	if !(spawnpos.x > right || spawnpos.x < left):
		spawnwolf()
		return
	if !(spawnpos.y < top || spawnpos.y > bottom):
		spawnwolf()
		return
	wolf.position = spawnpos
	add_child(wolf)

func _on_wolftimer_timeout() -> void:
	if get_tree().get_nodes_in_group("wolf").size() >= 15:
		pass
	else:
		spawnwolf()
	if get_tree().get_nodes_in_group("wolf").size() >= 7:
		pass
	else:
		spawnbear()
func _process(delta: float) -> void:
	cam = get_viewport().get_camera_2d().position
