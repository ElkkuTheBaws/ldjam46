extends RigidBody2D
class_name pickable

var MASS = 500
func _ready():
	add_to_group("pickable")
