extends Node2D

var Player = preload("res://player/Player.tscn")

export (int) var score_per_second = 1
export (int) var move_speed_pxs = 100
export (int) var section_pool_capacity = 4

var sections = [
	preload("res://section/start/Start.tscn"),
	preload("res://section/sneaky/Sneaky.tscn"),
	preload("res://section/drifter/Drifter.tscn")
]
var section_pool = []
var player
var score = 0 setget set_score

onready var last_section: Section = $StartSection
onready var score_timer: Timer = $ScoreTimer
onready var score_label: Label = $HUD/ScoreLabel


func _ready():
	set_physics_process(false)
	if not last_section.is_connected("cleared", self, "create_new_section"):
		last_section.connect("cleared", self, "create_new_section", [], CONNECT_DEFERRED)
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
	score = 0
	score_timer.wait_time = 1
	score_timer.start()
	Game.start()


func create_new_section():
	var new_section = sections[randi() % len(sections)].instance()
	new_section.position = last_section.position
	var height_offset = new_section.height - last_section.height
	new_section.position.y -= last_section.height + height_offset
	add_child(new_section)
	new_section.connect("cleared", self, "create_new_section", [], CONNECT_DEFERRED)
	last_section = new_section
	section_pool.push_front(new_section)
	if len(section_pool) > section_pool_capacity:
		section_pool.pop_back().queue_free()


func set_score(new_score):
	score = new_score
	score_label.text = str(score)


func _on_ScoreTimer_timeout():
	set_score(score + score_per_second)
