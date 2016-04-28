
extends Node2D

var haze = 1

var fscore = [0,0,0,0]

func _process(delta):
	haze -= 0.5 * delta
	get_node("lost").set_opacity(haze)
	
	if (haze <= 0):
		get_tree().change_scene("res://scenes/menu_screen.tscn")

func _ready():
	get_node("score").set_text("Score: " + str(global.score))
	get_node("sound").play("game-over")

	file_init_values()
	file_get_values()
	file_set_values()

	global.reset_values()
	set_process(true)

func file_init_values():
	if (global.file.file_exists(global.save_path) == false):
		global.file.open_encrypted_with_pass(global.save_path, global.file.WRITE, OS.get_unique_ID())
		
		var general_score = [3, 4, 1, 2]
		global.file.store_var(general_score)
		
		global.file.close()

func file_get_values():
	global.file.open_encrypted_with_pass(global.save_path, global.file.READ, OS.get_unique_ID())
	fscore = global.file.get_var()
	
#	print(fscore[0])
#	print(fscore[1])
#	print(fscore[2])
#	print(fscore[3])
	
	global.file.close()

func file_set_values():
	global.file.open_encrypted_with_pass(global.save_path, global.file.WRITE, OS.get_unique_ID())
	
	if (global.operator_state == global.SUBTRACTION):
		if (fscore[global.SUBTRACTION] < global.score):
			fscore[global.SUBTRACTION] = global.score
			global.file.set_var(fscore)
	
	global.file.close()

	print(fscore[0])
	print(fscore[1])
	print(fscore[2])
	print(fscore[3])