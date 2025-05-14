extends Node

var modules

func _ready():
	get_modules()

func get_modules():
	modules = {
		"attack": get_node("Attack"),
		"health": get_node("Health"),
		"movement": get_node("Movement")
	}
	print(modules)

func init_modules(config: Object):
	modules["attack"].init(config["attack"])
	modules["health"].init(config["health"])
	modules["movement"].init(config["movement"])

func get_config():
	return {
		"attack": modules["attack"].get_config(),
		"health": modules["health"].get_config(),
		"movement": modules["movement"].get_config()
	}
