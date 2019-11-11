extends Node

signal started
signal ended


func start():
	print("Game: start")
	emit_signal("started")


func end():
	print("Game: end")
	emit_signal("ended")
	get_tree().quit()
