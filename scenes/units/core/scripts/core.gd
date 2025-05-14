extends Node

#var team
#var rng = RandomNumberGenerator.new()
#var is_selected: bool = false
#var world
#
#var module_attack
#var module_health
#var module_movement
#
#func _ready():
	#module_attack
	#module_health
	#module_movement
	#
	#health = 100
	#damage = 15
	#attack_cooldown = rng.randi_range(30, 60)
	#attack_cooldown_timer = 0
#
	#is_ready_to_attack = false
	#
	#world = get_parent().get_parent()
	#
	#create_health_bar()
	#
	#input_pickable = true
#
#func _on_input_event(viewport, event, shape_idx):
	#if (
		#event is InputEventMouseButton 
		#and event.button_index == MOUSE_BUTTON_LEFT 
		#and event.pressed
		#):
			#order_select()
#
#func _unhandled_input(event):
	#if (
		#event is InputEventMouseButton 
		#and event.button_index == MOUSE_BUTTON_LEFT 
		#and event.pressed
		#):
			#order_to_move(get_global_mouse_position())
#
#func _physics_process(delta):
	#action_move()
	#action_detect_enemy()
#
#func set_team(team_assignment: String):
	#team = team_assignment
#
#func order_select():
	#if team == world.player_team:
		#is_selected = true
		#
#func action_detect_enemy():
	#for unit in units_in_attack_range:
		#if unit.team != team:
			#if is_ready_to_attack: 
				#action_attack(unit)
			#else:
				#attack_cooldown_timer += 1
				#
				#if attack_cooldown_timer == attack_cooldown:
					#is_ready_to_attack = true
					#attack_cooldown_timer = 0
