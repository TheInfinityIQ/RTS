extends Node

var players: Array[PlayerController] = []
var pre_fabbed_units: Array[int] = [UnitType.InfantryWarrior]

func _ready():
	players.append(get_parent().get_node("PlayerController"))
	
	var unit_id: int = 1
	var fabbed_unit: Unit
	
	for player in players:
		var position: Vector2 = Vector2.ZERO
		
		for pre_fabbed_unit in pre_fabbed_units:
			fabbed_unit = FactoryUnit.build(pre_fabbed_unit, position, unit_id, player.team)
			player.controllable_units.append(fabbed_unit)
			
			unit_id += 1
			position.x += fabbed_unit.scale.x + 250 # two-fifty seems like a good space between units
			
			get_node("Units").add_child(fabbed_unit)
