extends Node
class_name CoreModules

var node_attack: AttackModule
var node_health: HealthModule
var node_movement: MovementModule
var config: CoreModulesConfig

func _ready():
	setup_modules()

func init(new_config: CoreModulesConfig):
	config = new_config.duplicate(true)
	
	node_attack.init(config.attack)
	node_health.init(config.health)
	node_movement.init(config.movement)

func setup_modules():
	node_attack = get_node("Attack")
	node_health = get_node("Health")
	node_movement = get_node("Movement")
