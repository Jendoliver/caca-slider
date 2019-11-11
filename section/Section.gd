class_name Section
extends Node2D

signal cleared

export (int) var height = 640

onready var background: ColorRect = $Background
onready var sprite: Sprite = $Sprite
onready var section_cleared_area: Area2D = $SectionClearedArea


func _ready():
	background.margin_bottom = height


func _on_DeathArea_area_entered(area):
	if area is PlayerArea:
		print("Section: _on_DeathArea_area_entered (PLAYER IN)")
		Game.end()


func _on_SectionClearedArea_area_entered(area):
	if area is PlayerArea:
		print("Section: _on_SectionClearedArea_area_entered (PLAYER IN)")
		emit_signal("cleared")
		section_cleared_area.queue_free()
