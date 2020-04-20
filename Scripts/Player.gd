extends KinematicBody2D
class_name player


const up = Vector2.UP
const right = Vector2.RIGHT
const down = Vector2.DOWN
const left = Vector2.LEFT

var interractObj

#Variables related to throwable objects
var picked
export(int,100) var min_throw_distance = 5
export(int, 100) var max_throw_distance =  75
var charged = min_throw_distance
var hasObject = false
var descend = false
var charging = false
var readyToThrow = false
signal throw_length_changed(length)
signal screen_shake(amount, decay_rate, max_offset)
signal carried_object_changed(object, hasObject)
var current_direction = right
var throw_destination = current_direction

export (int, 0 , 1000) var MAX_SPEED = 500
export (int, 0 , 5000) var ACCELERATION = 2000
export (int, 0 , 200) var inertia = 50;

var motion = Vector2.ZERO

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var footstep = $AudioStreamPlayer2D
onready var throwsound = $AudioStreamPlayerThrow

func _physics_process(delta):
	var axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION * delta)
		footstep.stop()
		if hasObject:
			if !charging:
				animationState.travel("Idle Hold")
		else:
			if !charging:
				animationState.travel("Idle")
	else:
		apply_movement(axis * delta * ACCELERATION)
		if hasObject:
			animationTree.set("parameters/Idle Hold/blend_position", axis)
			animationTree.set("parameters/Run Hold/blend_position", axis)
			animationTree.set("parameters/Idle/blend_position", axis)
			animationTree.set("parameters/Throws/blend_position", axis)
			if !charging:
				if !footstep.playing:
					footstep.play(0)
				animationState.travel("Run Hold")
		else:
			animationTree.set("parameters/Idle/blend_position", axis)
			animationTree.set("parameters/Run/blend_position", axis)
			if !charging:
				if !footstep.playing:
					footstep.play(0)
				animationState.travel("Run")
#	if not charged > min_throw_distance:
	if !charging:
		motion = move_and_slide(motion, Vector2( 0, 0 ),false, 4, 0.785398,false)
	
	if not picked == null and picked.can_pick:
		
		if Input.is_action_just_pressed("ui_accept"):
			picked.picked = true
			hasObject = true
			readyToThrow = false
			emit_signal("carried_object_changed", picked, true)

	if readyToThrow:
		if not picked == null and picked.picked:
			if Input.is_action_pressed("ui_accept"):
					animationState.travel("Idle Hold")
					charge_throw()
			if Input.is_action_just_released("ui_accept"):
				picked.throw_object()
				throwsound.play(0)
	#			print(charged)
				var norm = (float(charged) - float(min_throw_distance)) / (float(max_throw_distance) - float(min_throw_distance))
	#			print(norm)
				emit_signal("screen_shake", 10 + norm * 100, 2, 1 + norm * 2) #Amount, decay and offset
				animationState.travel("Throws")
				charged = min_throw_distance
				hasObject = false
				readyToThrow = false
				emit_signal("carried_object_changed",picked, false)
	if readyToThrow == false and Input.is_action_just_released("ui_accept"):
		readyToThrow = true
			
			
			
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	
	set_current_direction()
	
	if not interractObj == null and Input.is_action_just_pressed("ui_pick"):
		match interractObj.get_class():
			"President":
				interractObj.talk()
	
func get_class():
	return "Player"
	
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

func charge_throw():
	charging = true
	
	if charged > max_throw_distance:
		descend = true
	if charged < min_throw_distance:
		descend = false
	if descend:
		charged += -1
	if not descend: 
		charged += 1
			
			
	emit_signal("throw_length_changed", charged)

func throw_animation_ended():
	charging = false
	animationState.travel("Idle")

func _on_PickArea_body_entered(body):
	interractObj = body
	if not body is pickable:
		return
	body.can_pick = true
	if not hasObject:
		picked = body
	


func _on_PickArea_body_exited(body: Node) -> void:
	if interractObj == body:
		interractObj = null
	if not body is pickable:
		return
	body.can_pick = false


func _on_Player_carried_object_changed(object, hasObject) -> void:
	pass # Replace with function body.
