class_name Section
extends Node2D

signal appeared_on_screen

export (int) var height = 640

onready var sprite: Sprite = $Sprite


func _on_CreateNotifier_screen_entered():
	print("Section: _on_CreateNotifier_screen_entered")
	emit_signal("appeared_on_screen")


func _on_FreeNotifier_screen_exited():
	print("Section: _on_FreeNotifier_screen_exited")
	queue_free()


func _on_DeathArea_area_entered(area):
	if area is PlayerArea:
		print("Arcade: _on_DeathArea_area_entered (PLAYER OUT)")
		Game.end()
	else:
		print("Arcade: _on_DeathArea_area_entered (UNRECOGNIZED AREA, repr below)")
		print(Nodes.repr(area))
