extends Node2D

var actor: Actor

func _ready():
	actor = get_node("Actor")
	var core_config: CoreModulesConfig = CoreModulesConfig.new()
	
	core_config.attack.damage = 25
	core_config.attack.max_range = 50
	core_config.attack.attack_cooldown = 5
	
	core_config.health.total_hitpoints = 250
	
	core_config.movement.movement_speed = 5
	
	actor.init_core(core_config)
