extends Object
class_name FactoryUnit

const UnitScene = preload("res://scenes/units/core/Unit.tscn")

static func build(unit_type: int, start_positon: Vector2, unit_id: int, unit_team: String) -> Unit:
	var blueprint: BlueprintUnit = BlueprintMapper.map[unit_type]
	var unit: Unit = UnitScene.instantiate()
	
	blueprint.config(unit, unit_id, unit_team)
	unit.position = start_positon
	var sprite = unit.get_node("Sprite2D")
	sprite.texture = load("res://assets/units/avatars/f_10.png")
	
	return unit
