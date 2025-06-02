extends Object
class_name FactoryUnit

static func build(unit_type: int, start_positon: Vector2, unit_id: int, unit_team: String) -> Unit:
	var blueprint: BlueprintUnit = BlueprintMapper.map[unit_type]
	var unit: Unit = Unit.new()
	
	blueprint.config(unit, unit_id, unit_team)
	unit.position = start_positon
	
	return unit
