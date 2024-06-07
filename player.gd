extends CharacterBody2D

@export var walk_speed = 4.0
const TILE_SIZE = 16

var initial_position = Vector2(0, 0)
var input_direction = Vector2(0, 0)
var is_moving = false
var percent_moved_to_next_tile = 0.0

func _ready():
	initial_position = position
	

func _physics_process(delta):
	if is_moving == false:
		process_player_input()
	elif input_direction != Vector2.ZERO:
		move(delta)
	else:
		is_moving = false
		
func process_player_input():
	# Reset input direction
	input_direction = Vector2.ZERO

	# Set input direction based on key presses
	input_direction.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	input_direction.y = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))

	# Check if any input direction is pressed
	if input_direction != Vector2.ZERO:
		initial_position = position
		is_moving = true

func move(delta):
	percent_moved_to_next_tile += walk_speed * delta
	if percent_moved_to_next_tile >= 1.0:
		position = initial_position + (TILE_SIZE * input_direction)
		percent_moved_to_next_tile = 0.0
		is_moving = false
	else:
		position = initial_position + (TILE_SIZE * input_direction * percent_moved_to_next_tile)
