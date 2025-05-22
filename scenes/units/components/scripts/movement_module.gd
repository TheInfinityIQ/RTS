extends Resource
class_name MovementModule

static func calculate_move(current_position: Vector2, target_position: Vector2, actor: CharacterBody2D, movement_speed: float):
	if (
			actor.get_slide_collision_count()
			or current_position.distance_to(target_position) < 15
		):
			actor.set_velocity(Vector2.ZERO)
			return
	
	actor.move_and_slide()
	actor.set_velocity(current_position.direction_to(target_position) * movement_speed)

#func order_to_move(target_position: Vector2):
	#if not is_selected:
		#return
	#target_move_position = target_position
	#set_is_moving(true)
	#var direction = global_position.direction_to(target_position)
	#set_velocity(direction * move_speed)
	#is_selected = false

#func order_stop_move():
	#target_move_position = Vector2.ZERO
	#set_velocity(Vector2.ZERO)

#func action_move():
	#if target_move_position != Vector2.ZERO:
		#move_and_slide()
		#if get_slide_collision_count():
			#order_stop_move()
		#if global_position.distance_to(target_move_position) < 5:
			#order_stop_move()
