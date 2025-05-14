extends Node

var damage: float
var min_range: float
var max_range: float
var attack_cooldown: float
var attack_cooldown_timer: float
var is_ready_to_attack: bool
var units_in_attack_range: Array[Node2D] = []

func get_config():
	return {
		"max_range": 0,
		"min_range": 0,
		"attack_cooldown": 0,
		"damage": 0
	}

func init(config: Object):
	min_range = config["min_range"]
	max_range = config["max_range"]
	attack_cooldown = config["attack_cooldown"]
	damage = config["damage"]
	
	is_ready_to_attack = false
	pass

func attack(enemy_to_attack: Node2D):
	enemy_to_attack.apply_damage(damage)
	is_ready_to_attack = false
