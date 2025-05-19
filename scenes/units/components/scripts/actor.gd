extends CharacterBody2D
class_name Actor

var _node_unit: Node2D
var _node_attack: AttackModule
var _node_health: HealthModule
var _node_movement: MovementModule

var attack_config: AttackConfig
var health_config: HealthConfig
var movement_config: MovementConfig

var is_selected: bool

func _ready():
	_node_unit = get_parent()

func init(new_attack_config: AttackConfig, new_movement_config: MovementConfig, new_health_config: HealthConfig):
	attack_config = new_attack_config
	movement_config = new_movement_config
	health_config = new_health_config

func _on_input_event(viewport, event, shape_idx):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed
		):
			select()

func _unhandled_input(event):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed
		):
			if is_selected:
				deselect()

func select():
	is_selected = true
	print("SELECTED!")

func deselect():
	is_selected = false
	print("DESELECTED!")
	move_and_slide()
