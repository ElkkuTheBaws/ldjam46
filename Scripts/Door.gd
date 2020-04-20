extends KinematicBody2D


export var id = 0
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var collisionshape = get_node("CollisionShape2D")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_Pressureplate_activated(isActivated, id) -> void:
	if self.id == id:
		if isActivated:
			open_door()
		else:
			close_door()


func open_door():
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(3,false)
	visible = false
	
func close_door():
	set_collision_layer_bit(3, true)
	set_collision_mask_bit(3,true)
	visible = true
