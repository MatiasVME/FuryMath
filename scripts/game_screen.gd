
extends Node2D

var num1 = 0.0
var num2 = 0.0

var correct_button = 0
var correct_answer = 0
var num_question = 0

var next_question = false

var haze = 1 # cambiar la opacidad del label

# Button wrong alternatives
var alt = [0, 0, 0]
var alt_index = 0

# Operators
const ADDITION = 0
const SUBTRACTION = 1
const MULTIPLICATION = 2
const DIVISION = 3

var operator_state

# Score system
var accumulated_time = 0

# Los niveles superiores o igual a LEVEL_WITH_TIME tienen tiempo
const LEVEL_WITH_TIME = 5

# Hacer que algunas acciones se ejecuten solo una vez
var one_time

func _ready():
	randomize()
	next_question = true
	one_time = true
	
	get_node("HBoxCont/lives").set_text("Lives: " + str(global.lives))
	get_node("HBoxCont/total_score").set_text("Score: " + str(global.score))
	
	set_process(true)

func _process(delta):
	if (next_question):
		reset_values()
		show_values()
		set_button_values()
		next_question = false
	
	if (global.lives == 0):
		get_tree().change_scene("res://scenes/lost_screen.tscn")
	elif (get_node("time_to_lost").get_value() == 0):
		global.lives = global.lives - 1
		get_node("HBoxCont/lives").set_text("Lives: " + str(global.lives))
		get_node("time_to_lost").set_value(100)
	elif (num_question == 10):
		num_question = 0
		next_level()
		get_tree().change_scene("res://scenes/win_screen.tscn")
	elif (global.current_level % 5 == 0 && one_time):
		get_node("reward").set_text("New Life!")
		global.lives += 1
		get_node("HBoxCont/lives").set_text("Lives: " + str(global.lives))
		one_time = false
	
	haze -= 1 * delta
	get_node("reward").set_opacity(haze)
	
	accumulated_time += delta
	
	# Si el nivel es menor que x la barra no esta habilitada
	if (global.current_level < LEVEL_WITH_TIME):
		get_node("time_to_lost").set_opacity(0)
	
	# Si el nivel es mayor o igual a x se empieza a perder tiempo
	if (global.current_level >= LEVEL_WITH_TIME):
		var value = get_node("time_to_lost").get_value()
		value -= global.lost_time * delta
		get_node("time_to_lost").set_value(value)

func show_values():
	if (global.operator_state == global.ADDITION):
		get_node("show").set_text(str(num1) + " + " + str(num2))
	elif (global.operator_state == global.SUBTRACTION):
		get_node("show").set_text(str(num1) + " - " + str(num2))
	elif (global.operator_state == global.MULTIPLICATION):
		get_node("show").set_text(str(num1) + " * " + str(num2))
	elif (global.operator_state == global.DIVISION):
		get_node("show").set_text(str(num1) + " / " + str(num2))
	
func reset_values():
	if (global.operator_state != global.DIVISION):
		num1 = int(rand_range(global.num_range_min, global.num_range_max))
		num2 = int(rand_range(global.num_range_min, global.num_range_max))
	else:
		num1 = int(rand_range(global.num_range_min, global.num_range_max))
		num2 = int(rand_range(global.num_range_min, global.num_range_max))
		
		if (num2 > num1):
			var aux = num2
			num2 = num1
			num1 = aux
	
func get_result():
	if (global.operator_state == global.ADDITION):
		return num1 + num2
	elif (global.operator_state == global.SUBTRACTION):
		return num1 - num2
	elif (global.operator_state == global.MULTIPLICATION):
		return num1 * num2
	elif (global.operator_state == global.DIVISION):
		return num1 / num2
	
func set_button_values():
	correct_button = int(rand_range(1, 5))
	
	reset_alternatives()
	alternative_generator()
	
	value_button_generator(correct_button, 1)
	value_button_generator(correct_button, 2)
	value_button_generator(correct_button, 3)
	value_button_generator(correct_button, 4)
	
func value_button_generator(correct_button, num_button):
	if (correct_button == num_button):
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(get_result()))
	else:
		get_node("VBoxContainer/opt" + str(num_button)).set_text(str(int(alt[alt_index])))
		alt_index += 1

func alternative_generator():
	var num_nearness = 5

	while (alt[0] == 0 || alt[0] == get_result()):
		alt[0] = rand_range(get_result() - num_nearness, get_result() + num_nearness + 1)
		alt[0] = round(alt[0])
	while (alt[1] == 0 || alt[1] == get_result() || alt[1] == alt[0]):
		alt[1] = rand_range(get_result() - num_nearness, get_result() + num_nearness + 1)
		alt[1] = round(alt[1])
	while (alt[2] == 0 || alt[2] == get_result() || alt[2] == alt[1]):
		alt[2] = rand_range(get_result() - num_nearness, get_result() + num_nearness + 1)
		alt[2] = round(alt[2])

func reset_alternatives():
	alt = [0, 0, 0]
	alt_index = 0

func answer_button(num_button):
	if (correct_button == num_button):
		correct_answer += 1
		add_score()
		accumulated_time = 0
		
		var value = get_node("time_to_lost").get_value()
		value += 10
		get_node("time_to_lost").set_value(value)
		
		get_node("sounds").play("good")
	else:
		global.lives -= 1
		get_node("reward").set_text("Bad :(")
		get_node("HBoxCont/lives").set_text("Lives: " + str(global.lives))
		
		get_node("sounds").play("bad")
	
	num_question += 1
	next_question = true
	haze = 1

func add_score():
	if (accumulated_time <= 1.5):
		global.score += 10
		get_node("reward").set_text("10 Points!")
	elif (accumulated_time < 2):
		global.score += 9
		get_node("reward").set_text("9 Points!")
	elif (accumulated_time < 3):
		global.score += 8
		get_node("reward").set_text("8 Points!")
	elif (accumulated_time < 4):
		global.score += 7
		get_node("reward").set_text("7 Points!")
	elif (accumulated_time < 5):
		global.score += 6
		get_node("reward").set_text("6 Points!")
	elif (accumulated_time < 6):
		global.score += 5
		get_node("reward").set_text("5 Points!")
	elif (accumulated_time < 7):
		global.score += 4
		get_node("reward").set_text("4 Points!")
	elif (accumulated_time < 8):
		global.score += 3
		get_node("reward").set_text("3 Points!")
	elif (accumulated_time < 9):
		global.score += 2
		get_node("reward").set_text("2 Points!")
	elif (accumulated_time > 10):
		global.score += 1
		get_node("reward").set_text("1 Points!")
	
	get_node("HBoxCont/total_score").set_text("Score: " + str(global.score))

func next_level():
	global.current_level += 1
	global.num_range_max += 1

	if (global.operator_state != global.DIVISION):
		global.num_range_min -= 1

	if (global.lost_time <= 5 && global.current_level > LEVEL_WITH_TIME):
		global.lost_time += 0.5

func _on_opt1_pressed():
	answer_button(1)

func _on_opt2_pressed():
	answer_button(2)

func _on_opt3_pressed():
	answer_button(3)

func _on_opt4_pressed():
	answer_button(4)
