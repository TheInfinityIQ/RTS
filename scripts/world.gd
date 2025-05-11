extends Node

var players = []
var units: Array = []
var teams = {}

func get_file_name(path: String):
	return path.split('/')[path.split('/').size() - 1].split('.')[0]

func _ready():
	get_units()
	get_teams()
	get_players()
	
	assign_teams_to_players()

func get_units():
	for child in get_child(1).get_children():
		units.append(child.get_child(2))

func get_teams():
	for unit in units:
		if get_file_name(unit.texture.resource_path) in teams:
			teams[get_file_name(unit.texture.resource_path)].append(unit)
		else:
			teams[get_file_name(unit.texture.resource_path)] = [unit]

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
