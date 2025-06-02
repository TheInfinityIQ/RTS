extends MovementBehaviour
class_name MovementInfantry

static func move(unit: Unit):
	if not unit.is_moving:
		return
	if unit.get_slide_collision_count():
		unit.set_velocity(Vector2.ZERO)
		return
	if unit.global_position.distance_to(unit.movement_target_position) < 15:
		unit.set_velocity(Vector2.ZERO)
		unit.is_moving = false
		return
	
	unit.move_and_slide()
	unit.set_velocity(unit.global_position.direction_to(unit.movement_target_position) * unit.movement_speed)
