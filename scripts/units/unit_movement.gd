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

var enemies_in_range = []

var is_selected: bool = false
var is_moving: bool = false
var target_move_position: Vector2
var direction: Vector2 = Vector2.ZERO

func get_file_name(path: String):
	return path.split('/')[path.split('/').size() - 1].split('.')[0]

func _ready():
	health = 100
	damage = 15
	team = get_file_name(get_child(2).texture.resource_path)
	attack_cooldown = rng.randi_range(30, 60)
	attack_cooldown_timer = 0

	is_ready_to_attack = false
	
	health_node = ColorRect.new()
	
	health_node.size.x = health
	health_node.size.y = 25
	health_node.color = Color(1, 0, 0)
	
	health_node.position.y -= 115
	health_node.position.x -= 50
	
	add_child(health_node)
	
	input_pickable = true

func _on_input_event(viewport, event, shape_idx):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed
		):
			is_selected = true

func _unhandled_input(event):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT 
		and event.pressed
		):
			order_to_move(get_global_mouse_position())

func _physics_process(delta):
	if target_move_position != Vector2.ZERO:
		move_and_slide()
		
		if global_position.distance_to(target_move_position) < 5:
			target_move_position = Vector2.ZERO
			velocity = Vector2.ZERO
			
	if enemies_in_range.size():
		if is_ready_to_attack: 
			action_attack()
		else:
			attack_cooldown_timer += 1
			
			if attack_cooldown_timer == attack_cooldown:
				is_ready_to_attack = true
				attack_cooldown_timer = 0

func _on_area_2d_body_entered(body):
	var node = get_parent().find_child(body.name, false)
	if node.name != self.name:
		enemies_in_range.append(body.name)
		print("BAD GUY!")

func _on_area_2d_body_exited(body):
	enemies_in_range = []
	print("BYE BYE!")

func order_select():
		is_selected = true

func order_to_move(target_position: Vector2):
	if not is_selected:
		return
	
	target_move_position = target_position
	
	print("Global {location}".format({"location": global_position}))
	print("New {location}".format({"location": target_position}))
	
	print("Unit is_moving!")
	is_moving = true
	
	direction = global_position.direction_to(target_position)
	velocity = direction * move_speed
	
	is_selected = false

func order_stop_move():
	target_move_position = Vector2.ZERO
	velocity = Vector2.ZERO

func action_move():
	if target_move_position != Vector2.ZERO:
		move_and_slide()
		
		if global_position.distance_to(target_move_position) < 5:
			order_stop_move()

func action_attack():
	print("TAKE YER")
	get_parent().find_child(enemies_in_range[0], false).apply_damage()
	is_ready_to_attack = false

func apply_damage():
	health -= 20
	health_node.size.x -= 20
	
	if health <= 0:
		queue_free()
