extends DetectBehaviour
class_name DetectMelee

static func detect(unit: Unit, detected: Node2D):
	if detected is not Unit:
		return
	scan(unit, detected)

static func scan(unit: Unit, detected: Unit):
	if detected.team != unit.team:
		unit.enemies_in_range[detected.id] = detected
