extends Node2D

var Player = preload("res://player/Player.tscn")
var LoseScreen = preload("res://ui/LoseScreen.tscn")

export (int) var score_per_second = 1
export (int) var move_speed_pxs = 100
export (int) var section_pool_capacity = 4
export (int) var initial_sections = 2

var sections = [
	preload("res://section/start/Start.tscn"),
	preload("res://section/sneaky/Sneaky.tscn"),
	preload("res://section/drifter/Drifter.tscn")
]
var section_pool = []
var last_section: Section
var score = 0 setget set_score
var hiscore

onready var score_timer: Timer = $ScoreTimer
onready var score_label: Label = $HUD/ScoreLabel
onready var player = $Player


func _ready():
	Game.connect("ended", self, "end_game")
	hiscore = load_hiscore()
	initialize()


func initialize():
	randomize()
	position = Vector2(0, 0)
	last_section = null
	set_physics_process(false)
	for i in range(initial_sections):
		create_new_section()
	set_process_input(true)


func restart():
	for i in range(len(section_pool)):
		section_pool.pop_back().queue_free()
	initialize()
	set_score(0)


func _physics_process(delta):
	position.y += move_speed_pxs * delta


func _input(event):
#	if event is InputEventKey and event.scancode == KEY_P:
#		print("Section pool len: ", len(section_pool))
#
#	if event is InputEventKey and event.scancode == KEY_D:
#		print(Nodes.repr(self))
#
#	if event is InputEventKey and event.scancode == KEY_K:
#		Game.end()
	
	if Game.is_started:
		return

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			start_game()


func start_game():
	set_physics_process(true)
	score = 0
	score_timer.wait_time = 1
	score_timer.start()
	Game.start()


func end_game():
	set_physics_process(false)
	save_hiscore()
	score_timer.stop()
	var lose_screen = LoseScreen.instance()
	add_child(lose_screen)
	lose_screen.score = score
	lose_screen.hiscore = hiscore
	lose_screen.connect("play_again_pressed", self, "restart")
	set_process_input(false)


func create_new_section():
	var new_section = sections[randi() % len(sections)].instance()
	var last_section_pos = last_section.position if last_section else Vector2(0, new_section.height)
	var last_section_height = last_section.height if last_section else new_section.height
	new_section.position = last_section_pos
	var height_offset = new_section.height - last_section_height
	new_section.position.y -= last_section_height + height_offset
	add_child(new_section)
	new_section.connect("cleared", self, "create_new_section", [], CONNECT_DEFERRED)
	last_section = new_section
	section_pool.push_front(new_section)
	if len(section_pool) > section_pool_capacity:
		section_pool.pop_back().queue_free()


func set_score(new_score):
	score = new_score
	score_label.text = str(score)
	if score > hiscore:
		hiscore = score


func _on_ScoreTimer_timeout():
	set_score(score + score_per_second)


func save_hiscore():
	if score < hiscore:
		return
		
	var save_file = File.new()
	save_file.open("user://savegame.sav", File.WRITE)
	save_file.store_line(to_json({ "arcade_hiscore" : hiscore }))
	save_file.close()


func load_hiscore() -> int:
	var save_file = File.new()
	if not save_file.file_exists("user://savegame.save"):
		return 0
	
	save_file.open("user://savegame.sav", File.READ)
	var json_obj = parse_json(save_file.get_line())
	save_file.close()
	return json_obj["arcade_hiscore"]
