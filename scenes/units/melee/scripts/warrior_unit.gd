extends Node2D

var actor: Actor

func _ready():
	actor = get_node("Actor")
	var attack_config: AttackConfig = AttackConfig.new()
	var movement_config: MovementConfig = MovementConfig.new()
	var health_config: HealthConfig = HealthConfig.new()
	
	attack_config.damage = 25
	attack_config.max_range = 50
	attack_config.attack_cooldown = 5
	
	health_config.total_hitpoints = 250
	
	movement_config.movement_speed = 1000
	
	actor.init(attack_config, movement_config, health_config, "res://assets/units/avatars/fntcr_03.PNG")
