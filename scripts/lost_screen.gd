
extends Node2D

var haze = 1

func _process(delta):
	haze -= 0.5 * delta
	get_node("lost").set_opacity(haze)
	
	if (haze <= 0):
		get_tree().change_scene("res://scenes/menu_screen.tscn")

func _ready():
	get_node("score").set_text("Score: " + str(global.score))
	get_node("sound").play("game-over")
	global.reset_values()
	set_process(true)

