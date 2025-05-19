extends Node
class_name AttackModule

var attack_cooldown_timer: float
var is_ready_to_attack: bool
var units_in_max_attack_range: Array[Node2D] = []
var units_in_min_attack_range: Array[Node2D] = []

var node_max_range: Area2D
var node_min_range: Area2D

var config: AttackConfig

func _ready():
	node_max_range = get_node("MaxRange")
	node_min_range = get_node("MinRange")

func init(new_config: AttackConfig):
	config = new_config.duplicate(true)
	is_ready_to_attack = false
	
	node_max_range.get_child(0).scale = Vector2(config.max_range, config.max_range)
	node_min_range.get_child(0).scale = Vector2(config.min_range, config.min_range)

func attack(enemy_to_attack: Node2D):
	enemy_to_attack.apply_damage(config.damage)
	is_ready_to_attack = false

func _on_max_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.

func _on_max_range_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.

func _on_min_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.

func _on_min_range_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.
