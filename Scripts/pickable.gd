extends KinematicBody2D
class_name pickable

onready var player_node = get_node("../Player/Position2D")
onready var player = get_node("../Player")

var MASS = 500
var speed = 30000
var can_pick = false
var picked = false
var inAir = false
var throwtime
var throw_direction = Vector2.RIGHT
var collision

func _ready():
	set_physics_process(true)
	add_to_group("pickable")
	
	
func _physics_process(delta):
	if can_pick == true:
		if Input.is_action_just_pressed("ui_pick"):
			picked = true
	if(picked):
		self.collision_layer = 2
		self.collision_mask = 2
		self.position = player_node.global_position + Vector2(0,-20)
		
		if Input.is_action_just_pressed("ui_accept"):
			throw_object(player.current_direction)
	else:
		self.collision_layer = 1
		self.collision_mask = 1
	if inAir:
		collision = move_and_collide(throw_direction * speed * delta)
		
		if collision: #Tests if object collides with something in air
			pass
		
#	self.position = player_node.global_position

func throw_object(var direction):
	inAir = true
	throw_direction = direction
	picked = false
	
	#Creating a timer for the throw distance
	throwtime = Timer.new()
	throwtime.one_shot = true
	add_child(throwtime)
	throwtime.connect("timeout",self,"_on_throwtime_timeout")
	throwtime.start(0.5)

func _on_throwtime_timeout():
	print("epic")
	inAir = false


