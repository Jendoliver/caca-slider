extends Node

signal started
signal ended
signal paused
signal resumed

export (int) var score_per_second = 1

onready var score_timer: Timer = $ScoreTimer

var score: int = 0


func _ready():
	init()


func init():
	reset_score()
	reset_score_timer()


func start():
	print("Game: start")
	init()
	score_timer.start()
	emit_signal("started")


func end():
	print("Game: end")
	score_timer.stop()
	emit_signal("ended")


func pause():
	print("Game: pause")
	score_timer.stop()
	emit_signal("paused")


func resume():
	print("Game: resume")
	score_timer.start()
	emit_signal("resumed")
	


func reset_score():
	print("Game: reset_score")
	score = 0


func reset_score_timer():
	print("Game: reset_score_timer")
	score_timer.wait_time = 1


func _on_ScoreTimer_timeout():
	score += score_per_second
