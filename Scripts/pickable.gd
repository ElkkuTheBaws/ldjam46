extends KinematicBody2D
class_name pickable

onready var player_node = get_node("../Player/Position2D")
onready var player: = get_node("../Player")
onready var raycast: = get_node("../Player/RayCast2D")

var MASS = 500
var speed = 200
var throw_distance = 50
var can_pick = false
var picked = false
var inAir = false
var throwtime
var collision
var tween : Tween

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
		self.position = player_node.global_position + Vector2(0,-5)
		
		if Input.is_action_just_pressed("ui_accept"):
			throw_object_still()

	#if inAir:
		#collision = move_and_collide(throw_direction * speed * delta)
		
		#if collision: #Tests if object collides with something in air
			#pass
		
#	self.position = player_node.global_position

func throw_object_still():
	inAir = true
	picked = false
	
	tween = Tween.new()
	add_child(tween)
	if raycast.is_colliding():
		tween.interpolate_property(self, "position", global_position, player.throw_destination+player.current_direction.normalized()*-3, 0.25,Tween.TRANS_BACK,Tween.EASE_OUT)
	else:
		tween.interpolate_property(self, "position", global_position, player.throw_destination, 0.5,Tween.TRANS_CIRC,Tween.EASE_OUT)
	tween.start()
	#Creating a timer for the throw distance
	throwtime = Timer.new()
	throwtime.one_shot = true
	add_child(throwtime)
	throwtime.connect("timeout",self,"_on_throwtime_timeout")
	throwtime.start(0.5)
	
#func throw_object(var direction: Vector2):
#	inAir = true
#	throw_direction = direction / 200
#	if throw_direction.length() < sqrt(2):
#		throw_direction = direction.normalized()
#	picked = false
#
#	#Creating a timer for the throw distance
#	throwtime = Timer.new()
#	throwtime.one_shot = true
#	add_child(throwtime)
#	throwtime.connect("timeout",self,"_on_throwtime_timeout")
#	throwtime.start(0.5)

func _on_throwtime_timeout():
	inAir = false
	self.collision_layer = 1
	self.collision_mask = 1


