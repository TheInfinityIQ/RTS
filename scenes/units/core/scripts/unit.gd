extends CharacterBody2D
class_name Unit

var attack_behaviour: AttackBehaviour
var movement_behaviour: MovementBehaviour
var health_behaviour: HealthBehaviour
var detect_behaviour: DetectBehaviour

var health_total: float
var health_current: float

var attack_max_range: float
var attack_min_range: float
var attack_cooldown: float
var attack_damage: float

var movement_speed: float
var movement_target_position: Vector2

var id: int
var is_selected: bool
var is_moving: bool
var enemies_in_range: Dictionary[int, Unit]
var team: String

func select():
	is_selected = true

func deselect():
	is_selected = false

func _process(delta: float) -> void:
	attack_behaviour.attack(self)
	movement_behaviour.move(self)

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
		and event.pressed
		):
			if not is_selected:
				return
			
			if event.button_index == MOUSE_BUTTON_LEFT:
				is_selected = false
				return
			
			if event.button_index == MOUSE_BUTTON_RIGHT:
				movement_target_position = get_global_mouse_position()
				is_moving = true

func _on_body_entered(body: Node2D) -> void:
	detect_behaviour.detect(self, body)

func _on_body_exited(body: Node2D) -> void:
	if body is not Unit:
		return
	enemies_in_range.erase(body.id)
