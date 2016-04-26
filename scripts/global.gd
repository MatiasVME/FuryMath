extends Node

var score = 0
var lives = 3

# operator state
const ADDITION = 0
const SUBTRACTION = 1
const MULTIPLICATION = 2
const DIVISION = 3
var operator_state = 0

# level system
var current_level = 1
var num_range_max = 6
var num_range_min = 1

# Progress bar
var lost_time = 1

func reset_values():
	score = 0
	current_level = 1
	num_range_max = 6
	num_range_min = 1
	lost_time = 1