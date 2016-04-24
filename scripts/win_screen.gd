
extends Node2D

var haze = 1
var one_time

func _process(delta):
	haze -= 0.5 * delta
	get_node("win").set_opacity(haze)
	
	if (haze < 0):
		get_tree().change_scene("res://scenes/game_screen.tscn")
	
	if (one_time):
		get_node("score").set_text("Score: " + str(global.score))
		get_node("level").set_text("Level: " + str(global.current_level))
		one_time = false

func _ready():
	one_time = true
	get_node("sound").play("win")
	set_process(true)
