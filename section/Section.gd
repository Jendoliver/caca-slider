class_name Section
extends Node2D

signal appeared_on_screen

export (int) var height = 640

onready var background: ColorRect = $Background
onready var sprite: Sprite = $Sprite


func _ready():
	background.margin_bottom = height


func _on_DeathArea_area_entered(area):
	if area is PlayerArea:
		print("Arcade: _on_DeathArea_area_entered (PLAYER IN)")
		Game.end()


func _on_CreateNotifier_viewport_entered(viewport):
	print("Section: _on_CreateNotifier_viewport_entered")
	emit_signal("appeared_on_screen")


func _on_FreeNotifier_viewport_exited(viewport):
	print("Section: _on_FreeNotifier_viewport_exited")
	queue_free()
