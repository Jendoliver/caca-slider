extends Sprite

onready var hitbox = $PlayerArea


func _ready():
	end_run()
	Game.connect("started", self, "start_run")
	Game.connect("ended", self, "end_run")


func _process(delta):
	global_position = get_global_mouse_position()


func start_run():
	show()
	hitbox.monitorable = true


func end_run():
	hide()
	hitbox.monitorable = false
