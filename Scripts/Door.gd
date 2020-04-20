extends KinematicBody2D


export var id = 0
export(int, "House Door Front", "House Door Side") var doors
var doorup
var dooractive
var doordown
onready var door_sprite = $Sprite
# var a: int = 2
# var b: String = "text"
onready var collisionshape = get_node("CollisionShape2D")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		match doors:
			0:
				doorup = preload("res://Textures/doors/16x16 tile doors_0.png")
				doordown = preload("res://Textures/doors/16x16 tile doors_2.png")
				dooractive = preload("res://Textures/doors/16x16 tile doors_1.png")
				door_sprite.texture = doorup
			1:
				doorup = preload("res://Textures/doors/16x16 tile doors_3.png")
				doordown = preload("res://Textures/doors/16x16 tile doors_5.png")
				dooractive = preload("res://Textures/doors/16x16 tile doors_4.png")
				door_sprite.texture = doorup



func _on_Pressureplate_activated(isActivated, id) -> void:
	if self.id == id:
		if isActivated:
			open_door()
		else:
			close_door()


func open_door():
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(3,false)
	door_sprite.texture = doordown
#	visible = false
	
func close_door():
	set_collision_layer_bit(3, true)
	set_collision_mask_bit(3,true)
	door_sprite.texture = doorup
#	visible = true
