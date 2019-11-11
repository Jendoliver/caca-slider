extends Node2D

var Player = preload("res://player/Player.tscn")

export (int) var move_speed_pxs = 100
export (int) var section_pool_capacity = 4

var sections = [
	preload("res://section/start/Start.tscn"),
	preload("res://section/sneaky/Sneaky.tscn"),
	preload("res://section/drifter/Drifter.tscn")
]
var section_pool = []
var player

onready var last_section: Section = $StartSection


func _ready():
	set_physics_process(false)
	section_pool.append(last_section)
	create_new_section()


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
	new_section.position = last_section.position
	var height_offset = new_section.height - last_section.height
	new_section.position.y -= last_section.height + height_offset
	add_child(new_section)
	new_section.connect("cleared", self, "create_new_section")
	last_section = new_section
	section_pool.push_front(new_section)
	if len(section_pool) > section_pool_capacity:
		section_pool.pop_back().queue_free()
