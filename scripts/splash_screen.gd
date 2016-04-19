
extends Node2D

var TOTAL_TIME = 3
var accumulated_time = 0

func _process(delta):
	accumulated_time += delta
	
	if (TOTAL_TIME < accumulated_time):
		get_tree().change_scene("res://scenes/menu_screen.tscn")

func _ready():
	set_process(true)


