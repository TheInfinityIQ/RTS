extends Node

var players = []
var units: Array = []
var teams = {}

func get_unit_sprite_file_name(unit: CharacterBody2D):
	var path = unit.get_child(2).texture.resource_path
	return path.split('/')[path.split('/').size() - 1].split('.')[0]

func _ready():
	get_units()
	get_teams()
	get_players()
	
	assign_teams_to_players()

func get_units():
	for child in get_child(1).get_children():
		units.append(child)

func get_teams():
	var team_name
	
	for unit in units:
		team_name = get_unit_sprite_file_name(unit)
		unit.set_team(team_name)
		
		if team_name in teams:
			teams[team_name].append(unit)
		else:
			teams[team_name] = [unit]

func get_players():
	var nodes = get_parent().get_children()
	for node in nodes:
		if node.name == "PlayerController":
			players.append(node)
			
	print(players)

func assign_teams_to_players():
	var index = 0
	
	for team in teams:
		if index + 1 > players.size():
			players[index].assign_controllable_units(team)
			index += 1
		else: 
			break
	
	print(teams)
