extends Node2D

var Player = preload("res://player/Player.tscn")

export (int) var move_speed_pxs = 100

var sections = [
	preload("res://section/start/Start.tscn"),
	preload("res://section/sneaky/Sneaky.tscn"),
	preload("res://section/drifter/Drifter.tscn")
]
var player

onready var last_created_section: Section = $StartSection


func _ready():
	set_physics_process(false)


func _physics_process(delta):
	position.y += move_speed_pxs * delta


func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			start_game()


func start_game():
	player = Player.instance()
	add_child(player)
	set_physics_process(true)
	Game.start()


func create_new_section():
	print("Arcade: create_new_section")
	var new_section = sections[randi() % len(sections)].instance()
	new_section.global_position = last_created_section.global_position
	new_section.global_position.y -= last_created_section.height
	add_child(new_section)
	new_section.connect("appeared_on_screen", self, "create_new_section")
	last_created_section = new_section
	print(Nodes.repr(self, true))
