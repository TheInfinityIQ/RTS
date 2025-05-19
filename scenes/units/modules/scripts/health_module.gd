extends Node
class_name HealthModule

var current_hitpoints: float
var node_health_bar: ColorRect

var config: HealthConfig

func init(new_config: HealthConfig):
	config = new_config.duplicate(true)
	current_hitpoints = config.total_hitpoints

func create_health_bar():
	node_health_bar = ColorRect.new()
	
	# Will overlap with some unit sprite if not set
	node_health_bar.set_z_index(998)
	
	node_health_bar.size.x = current_hitpoints
	node_health_bar.size.y = 25
	node_health_bar.color = Color(1, 0, 0)
	
	node_health_bar.position.y -= 115
	node_health_bar.position.x -= 50
	
	add_child(node_health_bar)

func apply_damage(damage: float):
	current_hitpoints -= damage
	node_health_bar.size.x -= damage
	
	if current_hitpoints <= 0:
		destroy_unit()

func destroy_unit():
	queue_free()
