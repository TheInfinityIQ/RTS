extends Node
class_name MovementModule

var is_moving: bool
var target_move_position: Vector2

var config: MovementConfig

func init(new_config: MovementConfig): 
	config = new_config.duplicate(true)
	
	target_move_position = Vector2.ZERO
	is_moving = false
