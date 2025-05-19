extends CharacterBody2D
class_name Actor

var _node_unit: Node2D

var attack_config: AttackConfig
var health_config: HealthConfig
var movement_config: MovementConfig

var is_selected: bool
var is_moving: bool

var target_move_position: Vector2

func _physics_process(delta):
	_update_move()
	#_update_detect_enemy()

func _update_move():
	if not is_moving:
		return
	
	MovementModule.calculate_move(global_position, target_move_position, self, movement_config.movement_speed)

func _set_target_move_position(target_position: Vector2):
	if not is_selected:
		return
	
	var world = get_parent().get_parent().get_parent()
	var move_area: ColorRect = ColorRect.new()
	move_area.position = target_position
	move_area.size.x = 75
	move_area.size.y = 75
	move_area.color = Color(1, 0, 0)
	
	world.add_child(move_area)
	
	target_move_position = target_position
	is_moving = true

func _ready():
	_node_unit = get_parent()

func init(new_attack_config: AttackConfig, new_movement_config: MovementConfig, new_health_config: HealthConfig, texture_path: String):
	attack_config = new_attack_config
	movement_config = new_movement_config
	health_config = new_health_config
	
	get_node("Sprite2D").texture.resource_path = texture_path

func select():
	is_selected = true
	print("SELECTED!")

func deselect():
	is_selected = false
	print("DESELECTED!")
	move_and_slide()

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
				_set_target_move_position(get_global_mouse_position())
