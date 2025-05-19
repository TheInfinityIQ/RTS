extends Node2D

var actor: Actor

func _ready():
	actor = get_node("Actor")
	var attack_config: AttackConfig = AttackConfig.new()
	var movement_config: MovementConfig = MovementConfig.new()
	var health_config: HealthConfig = HealthConfig.new()
	
	attack_config.attack.damage = 25
	attack_config.attack.max_range = 50
	attack_config.attack.attack_cooldown = 5
	
	health_config.health.total_hitpoints = 250
	
	movement_config.movement.movement_speed = 5
	
	actor.init(attack_config, movement_config, health_config)
