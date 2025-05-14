extends Node

var movement_speed: float
var is_moving: bool
var target_move_position: Vector2

func get_config():
	return {
		"speed": 1
	}

func init(config: Object): 
	movement_speed = config["movement_speed"]
	
	target_move_position = Vector2.ZERO
	is_moving = false

func set_is_moving(value: bool):
	is_moving = value

func order_to_move(target_position: Vector2):
	target_move_position = target_position
	set_is_moving(true)
	
	#var direction = global_position.direction_to(target_position)
	#set_velocity(direction * move_speed)

func order_stop_move():
	target_move_position = Vector2.ZERO
	#set_velocity(Vector2.ZERO)

func move():
	if target_move_position != Vector2.ZERO:
		pass
		#move_and_slide()
		#if get_slide_collision_count():
			#order_stop_move()
		#
		#if global_position.distance_to(target_move_position) < 5:
			#order_stop_move()
