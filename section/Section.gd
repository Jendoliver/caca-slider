class_name Section
extends Node2D

signal appeared_on_screen

export (int) var height = 640

onready var sprite: Sprite = $Sprite


func _ready():
	pass


func _on_SafeArea_area_entered(area):
	print("Section: SafeArea area entered: ", area.name, area)


func _on_SafeArea_area_exited(area: PlayerArea):
	if area:
		print("Section: _on_SafeArea_area_exited (PLAYER OUT)")
		Game.end()
	else:
		print("Section: _on_SafeArea_area_exited (UNRECOGNIZED AREA: %s, name: %s)" % area.name)


func _on_CreateNotifier_screen_entered():
	print("Section: _on_CreateNotifier_screen_entered")
	emit_signal("appeared_on_screen")


func _on_FreeNotifier_screen_exited():
	print("Section: _on_FreeNotifier_screen_exited")
	queue_free()
