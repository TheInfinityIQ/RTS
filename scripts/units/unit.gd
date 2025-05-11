extends CharacterBody2D

@export var move_speed := 100.0

var health
var health_node
var damage
var team
var attack_cooldown
var attack_cooldown_timer
var is_ready_to_attack

var rng = RandomNumberGenerator.new()

var units_in_attack_range = []

var is_selected: bool = false
var is_moving: bool = false
var target_move_position: Vector2

func set_team(team_assignment: String):
	team = team_assignment
	
func set_is_moving(value: bool):
	is_moving = value

func _ready():
	health = 100
	damage = 15
	attack_cooldown = rng.randi_range(30, 60)
	attack_cooldown_timer = 0

	is_ready_to_attack = false
	
	create_health_bar()
	
	input_pickable = true

func _on_input_event(viewport, event, shape_idx):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed
		):
			order_select()

func _unhandled_input(event):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed
		):
			order_to_move(get_global_mouse_position())

func _physics_process(delta):
	action_move()
	action_detect_enemy()

func _on_area_2d_body_entered(body):
	var node = get_parent().find_child(body.name, false)
	if node.name != self.name:
		units_in_attack_range.append(body)
		print("BAD GUY!")

func _on_area_2d_body_exited(body):
	units_in_attack_range = []
	print("BYE BYE!")

func order_select():
		is_selected = true

func order_to_move(target_position: Vector2):
	if not is_selected:
		return
	
	target_move_position = target_position
	set_is_moving(true)
	
	var direction = global_position.direction_to(target_position)
	set_velocity(direction * move_speed)
	
	is_selected = false

func order_stop_move():
	target_move_position = Vector2.ZERO
	set_velocity(Vector2.ZERO)

func action_move():
	if target_move_position != Vector2.ZERO:
		move_and_slide()
		
		if global_position.distance_to(target_move_position) < 5:
			order_stop_move()

func action_detect_enemy():
	for unit in units_in_attack_range:
		if unit.team != team:
			if is_ready_to_attack: 
				action_attack(unit)
			else:
				attack_cooldown_timer += 1
				
				if attack_cooldown_timer == attack_cooldown:
					is_ready_to_attack = true
					attack_cooldown_timer = 0

func action_attack(enemy_to_attack):
	enemy_to_attack.apply_damage()
	is_ready_to_attack = false

func apply_damage():
	health -= 20
	health_node.size.x -= 20
	
	if health <= 0:
		queue_free()

func create_health_bar():
	health_node = ColorRect.new()
	
	health_node.set_z_index(998)
	
	health_node.size.x = health
	health_node.size.y = 25
	health_node.color = Color(1, 0, 0)
	
	health_node.position.y -= 115
	health_node.position.x -= 50
	
	add_child(health_node)
