extends Sprite


func _ready():
	Game.connect("started", self, "start_run")
	Game.connect("ended", self, "end_run")


func _process(delta):
	global_position = get_global_mouse_position()


func start_run():
	show()
	toggle_collisions(true)


func end_run():
	hide()
	toggle_collisions(false)


func toggle_collisions(enable):
	for child in get_children():
		if child is PlayerArea:
			child.monitorable = enable
