extends Node

var total_hitpoints: float
var current_hitpoints: float
var health_node: ColorRect

func get_config():
	return {
		"total_hitpoints": 100
	}

func init(config: Object):
	total_hitpoints = config["total_hitpoints"]
	current_hitpoints = config["total_hitpoints"]

func create_health_bar():
	health_node = ColorRect.new()
	
	# Will overlap with some unit sprite if not set
	health_node.set_z_index(998)
	
	health_node.size.x = current_hitpoints
	health_node.size.y = 25
	health_node.color = Color(1, 0, 0)
	
	health_node.position.y -= 115
	health_node.position.x -= 50
	
	add_child(health_node)

func apply_damage(damage: float):
	current_hitpoints -= damage
	health_node.size.x -= damage
	
	if current_hitpoints <= 0:
		destroy_unit()

func destroy_unit():
	queue_free()
