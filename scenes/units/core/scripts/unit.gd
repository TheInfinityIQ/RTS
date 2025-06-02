extends CharacterBody2D
class_name Unit

# -----------------------
# ----- Identifiers -----
# -----------------------
var id: int
var team: String

# ------------------------
# ----- Configurable ----- 
# ------------------------
var attack_behaviour: AttackBehaviour
var movement_behaviour: MovementBehaviour
var health_behaviour: HealthBehaviour
var detect_behaviour: DetectBehaviour

var health_total: float

var attack_max_range: float
var attack_min_range: float
var attack_cooldown: float
var attack_damage: float

var movement_speed: float
var sprite_path: String

# -------------------
# ----- Dynamic -----
# -------------------
var is_selected: bool = false
var is_moving: bool = false
var enemies_in_range: Dictionary[int, Unit] = {}
var movement_target_position: Vector2 = Vector2.ZERO
var health_current: float

func select():
	print("Selected")
	is_selected = true

func deselect():
	print("Deselected")
	is_selected = false

func _process(delta: float):
	attack_behaviour.attack(self)
	movement_behaviour.move(self)

func _input_event(viewport, event, shape_idx):
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
				deselect()
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
