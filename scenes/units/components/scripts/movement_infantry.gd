extends MovementBehaviour

func move(actor: Unit):
	if not actor.is_moving:
		return
	if actor.get_slide_collision_count():
		actor.set_velocity(Vector2.ZERO)
		return
	if actor.global_position.distance_to(actor.movement_target_position) < 15:
		actor.set_velocity(Vector2.ZERO)
		actor.is_moving = false
		return
	
	actor.move_and_slide()
	actor.set_velocity(actor.global_position.direction_to(actor.movement_target_position) * actor.movement_speed)
