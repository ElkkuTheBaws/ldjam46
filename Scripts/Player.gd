extends KinematicBody2D
class_name player


const up = Vector2.UP
const right = Vector2.RIGHT
const down = Vector2.DOWN
const left = Vector2.LEFT


var current_direction = right
var throw_destination = current_direction
export (int, 0 , 1000) var MAX_SPEED = 500
export (int, 0 , 5000) var ACCELERATION = 2000
export (int, 0 , 200) var inertia = 50;
var motion = Vector2.ZERO

func _physics_process(delta):
	var axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
	else:
		apply_movement(axis * delta * ACCELERATION)
	motion = move_and_slide(motion, Vector2( 0, 0 ),false, 4, 0.785398,false)
	
	set_current_direction()
	
#	for index in get_slide_count():
#		var collision = get_slide_collision(index)r
#		if collision.collider.is_in_group("pickable"):
#			collision.collider.apply_central_impulse(-collision.normal * inertia)
	
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()
func apply_movement(acceleration):
	motion += acceleration;
	motion = motion.clamped(MAX_SPEED)

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO

func set_current_direction():
	if Input.is_action_pressed("ui_right"):
		 current_direction = right
	if Input.is_action_pressed("ui_left"):
		current_direction = left
	if Input.is_action_pressed("ui_down"):
		current_direction = down
	if Input.is_action_pressed("ui_up"):
		current_direction = up


func _on_PickArea_body_entered(body):
	if not body is pickable:
		return
	body.can_pick = true


func _on_PickArea_body_exited(body: Node) -> void:
	if not body is pickable:
		return
	body.can_pick = false
