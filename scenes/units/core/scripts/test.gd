extends Node2D

var core_modules
var core_modules_config

func _ready():
	core_modules = get_node("CoreModules")
	core_modules_config = core_modules.get_config()
	
	core_modules_config["attack"]["max_range"] = 5
	core_modules_config["attack"]["min_range"] = -1
	core_modules_config["attack"]["attack_cooldown_time"] = 5
	core_modules_config["attack"]["damage"] = 20
	
	core_modules_config["health"]["total_hitpoints"] = 250
	
	core_modules_config["movement"]["movement_speed"] = 2
