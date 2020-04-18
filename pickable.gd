extends RigidBody2D
class_name pickable

var MASS = 500
onready var player_node = get_node("../Player/Position2D")
func _ready():
	set_physics_process(false)
	add_to_group("pickable")
	
	
func _physics_process(delta):
	self.position = player_node.global_position
