extends CharacterBody2D
class_name Actor

var _node_unit: Node2D
var _node_core_modules: CoreModules

func _ready():
	_node_unit = get_parent()
	_node_core_modules = get_node("CoreModules")
	
	print(_node_core_modules)

func init_core(new_config: CoreModulesConfig):
	_node_core_modules.init(new_config.duplicate(true))

func _on_input_event(viewport, event, shape_idx):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed
		):
			print("SELECTED")
