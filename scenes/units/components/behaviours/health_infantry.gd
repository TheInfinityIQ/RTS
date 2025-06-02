extends HealthBehaviour
class_name HealthInfantry

static func damage(unit: Unit, amount: float):
	unit.health_total -= abs(amount)
	
	if unit.health_total <= 0:
		destroy(unit)

static func destroy(unit: Unit):
	print("BLEH")
