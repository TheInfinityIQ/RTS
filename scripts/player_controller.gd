extends Node2D

@export var move_speed := 500.0    # Movement speed (pixels per second)
@export var zoom_step := 0.1        # How much to zoom in/out per wheel tick
@export var max_zoom_in := 0.5      # Maximum zoom-in (smallest scale)
@export var max_zoom_out := 2.0     # Maximum zoom-out (largest scale)
@export var zoom_speed := 50  # How quickly to interpolate towards zoom target

var target_zoom = Vector2.ZERO
var camera: Camera2D

# Box Selection Variables
var selection_start_point = Vector2.ZERO
var selection_box = null
var is_selecting = false
var selected_units = []

var world: Node2D

# Game Variabels
var team: String
var controllable_units = []

func _ready():
	camera = $Camera2D  # Cache the Camera2D node
	camera.zoom = Vector2(1, 1)  # Start at default zoom (1x)
	target_zoom = camera.zoom
	
	world = get_parent().get_child(0)

func _process(delta):
	handle_movement(delta)
	apply_zoom(delta)
	update_selection_box()
	
func handle_movement(delta):
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		position += input_vector * move_speed * delta

func apply_zoom(delta):
	var distance :Vector2 = target_zoom - camera.zoom
	var speed_factor :float = clamp(distance.length(), 0.1, 10)  # Bigger distance = faster zoom
	camera.zoom += distance * zoom_speed * speed_factor * delta # Smooths over curve due to speed_factor instead of linearly via lerp

func _input(event):
	if event is InputEventMouseButton:
		handle_zoom(event)
		handle_box_select(event)

func handle_zoom(event):
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		calculate_zoom(zoom_step)
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		calculate_zoom(-zoom_step)

func calculate_zoom(amount: float):
	var new_zoom := camera.zoom + Vector2(amount, amount)
	new_zoom.x = clamp(new_zoom.x, max_zoom_in, max_zoom_out)
	new_zoom.y = clamp(new_zoom.y, max_zoom_in, max_zoom_out)
	target_zoom = new_zoom

func handle_box_select(event):
	if event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			selected_units = []
			
			selection_start_point = get_relative_global_mouse_pos()
			is_selecting = true
			
			selection_box = ColorRect.new()
			selection_box.color = Color(0, 0.5, 1, 0.2)  # Light blue, semi-transparentc
			selection_box.size = Vector2.ZERO
			selection_box.position = selection_start_point
			add_child(selection_box)
		else:
			is_selecting = false
			box_select_units()
			selection_box.queue_free()
			selection_box = null

func box_select_units():
	var units = world.get_child(1).get_children()
	
	# Offset due to box being draw with relative_mouse_pos to PlayerController pos
	var box_start: Vector2 = Vector2.ZERO
	var mouse_pos = get_global_mouse_position()
	box_start.x = mouse_pos.x - selection_box.size.x
	box_start.y = mouse_pos.y - selection_box.size.y
	
	for unit in units: 
		if within_bounds(
				unit.position
				, box_start.x
				, box_start.x + selection_box.size.x
				, box_start.y
				, box_start.y + selection_box.size.y
			):
			selected_units.append(unit)
			unit.order_select()

func within_bounds(test_position, lower_x_bound, upper_x_bound, lower_y_bound, upper_y_bound):
	print(get_global_mouse_position())
	
	if (
		test_position.x > lower_x_bound 
		and test_position.x <= upper_x_bound 
		and test_position.y > lower_y_bound 
		and test_position.y <= upper_y_bound
	):
		return true
		
	return false

func get_relative_global_mouse_pos():
	var relative_pos: Vector2 = Vector2.ZERO
	var camera_pos: Vector2 = get_child(0).get_parent().position
	var global_pos: Vector2 = get_global_mouse_position()
	relative_pos.x = global_pos.x - camera_pos.x
	relative_pos.y = global_pos.y - camera_pos.y
	
	return relative_pos

func update_selection_box():
	if not selection_box:
		return
	
	# Calculate the area
	var rect_size = get_relative_global_mouse_pos() - selection_start_point
	selection_box.position = selection_start_point
	selection_box.size = rect_size
	
	# Correct direction if dragging backwards
	if rect_size.x < 0:
		selection_box.position.x += rect_size.x
		selection_box.size.x = abs(rect_size.x)
	if rect_size.y < 0:
		selection_box.position.y += rect_size.y
		selection_box.size.y = abs(rect_size.y)

func assign_controllable_units(units: Array):
	controllable_units = units
