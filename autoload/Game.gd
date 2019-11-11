extends Node

signal started
signal ended

var is_started = false


func start():
	print("Game: start")
	is_started = true
	emit_signal("started")


func end():
	if not is_started:
		return

	print("Game: end")
	is_started = false
	emit_signal("ended")
