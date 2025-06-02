extends BlueprintUnit
class_name BlueprintInfantryWarrior

static func config(unit: Unit, unit_id: int, unit_team: String):
	unit.attack_behaviour = AttackMelee.new()
	unit.movement_behaviour = MovementInfantry.new()
	unit.health_behaviour = HealthInfantry.new()
	unit.detect_behaviour = DetectMelee.new()
	
	unit.attack_max_range = 500
	unit.attack_min_range = 0
	unit.attack_cooldown = 3
	unit.attack_damage = 20
	
	unit.movement_speed = 500
	
	unit.sprite_path = "res://assets/units/avatars/fntcr_03.PNG"
	
	unit.team = unit_team
	unit.id = unit_id
