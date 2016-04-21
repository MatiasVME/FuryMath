
extends Node2D

var haze = 1

func _process(delta):
	haze -= 0.5 * delta
	get_node("win").set_opacity(haze)
	
	if (haze < 0):
		get_tree().change_scene("res://scenes/menu_screen.tscn")

func _ready():
	set_process(true)
