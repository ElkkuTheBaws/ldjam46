extends KinematicBody2D
class_name Enemy

var MAX_SPEED = 200
var motion = Vector2.ZERO
var HP = 2

func _physics_process(delta: float) -> void:
	return

func lose_hp() -> void:
	HP -= 1
	if(HP == 0):
		queue_free()
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

