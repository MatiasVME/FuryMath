
extends Node2D

var haze = 1

var score_path = "user://score.txt"

var add
var sub
var mult
var div

func _process(delta):
	haze -= 0.5 * delta
	get_node("lost").set_opacity(haze)
	
	if (haze <= 0):
		get_tree().change_scene("res://scenes/menu_screen.tscn")

func _ready():
	get_node("score").set_text("Score: " + str(global.score))
	get_node("sound").play("game-over")

	load_score()
	save_score()
	
	global.reset_values()
	set_process(true)
	
func save_score():
	var save_score = File.new()
	save_score.open(score_path, save_score.WRITE)
	
	var score_value = get_node("score").get_text()
	
	if (global.operator_state == global.ADDITION && global.score > add):
		save_score.store_line(str(global.score))
		save_score.store_line(str(sub))
		save_score.store_line(str(mult))
		save_score.store_line(str(div))
	elif (global.operator_state == global.SUBTRACTION && global.score > sub):
		save_score.store_line(str(add))
		save_score.store_line(str(global.score))
		save_score.store_line(str(mult))
		save_score.store_line(str(div))
	elif (global.operator_state == global.MULTIPLICATION && global.score > mult):
		save_score.store_line(str(add))
		save_score.store_line(str(sub))
		save_score.store_line(str(global.score))
		save_score.store_line(str(div))
	elif (global.operator_state == global.DIVISION && global.score > div):
		save_score.store_line(str(add))
		save_score.store_line(str(sub))
		save_score.store_line(str(mult))
		save_score.store_line(str(global.score))
	else:
		save_score.store_line(str(add))
		save_score.store_line(str(sub))
		save_score.store_line(str(mult))
		save_score.store_line(str(div))
	
	save_score.close()
	
func load_score():
	var save_score = File.new()
	
	save_score.open(score_path, save_score.READ)
	
	add = int(save_score.get_line())
	sub = int(save_score.get_line())
	mult = int(save_score.get_line())
	div = int(save_score.get_line())
	
	save_score.close()