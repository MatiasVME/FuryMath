
extends Node2D

var TOTAL_TIME = 3
var accumulated_time = 0
var accumulated_opacity = 1

func _process(delta):
	accumulated_time += delta
	accumulated_opacity -= 0.25 * delta
	get_node("splash").set_opacity(accumulated_opacity)
	
	if (TOTAL_TIME < accumulated_time):
		get_tree().change_scene("res://scenes/menu_screen.tscn")

func _ready():
	set_process(true)


