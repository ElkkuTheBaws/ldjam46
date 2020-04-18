extends RigidBody2D
class_name pickable

var MASS = 500
var can_pick = false
var picked = false
onready var player_node = get_node("../Player/Position2D")
func _ready():
	set_physics_process(true)
	add_to_group("pickable")
	
	
func _physics_process(delta):
	if can_pick == true:
		if Input.is_action_just_pressed("ui_pick"):
			picked = true
	
	if(picked):
		print("picked " + self.name)
		picked = false
#	self.position = player_node.global_position
