extends Enemy
class_name enemy
export var move_speed = 20.0
export var min_distance = 100.0
onready var nav_2d : Navigation2D = get_node("../Navigation2D")	
onready var pleijeri = get_node("../President")	
#onready var line_2D = get_node("../Line2D")
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

var path : = PoolVector2Array()
var tplayer : president
var chase = false
var can_move = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	set_physics_process(false)
	pass


func _physics_process(delta: float) -> void:
	if can_move:
		var move_distance = (move_speed * delta)
		if chase:
			calculate_path()
		if !picked:
			move_along_path(move_distance, delta)


func _on_PlayerDetector_body_entered(body: Node) -> void:
	if not body is president:
		return
	tplayer = body
	chase = true
	can_move = true
#	set_physics_process(true)

func calculate_path():
	var new_path = nav_2d.get_simple_path(self.global_position, pleijeri.position)
	path = new_path
	#line_2D.points = new_path
	if path.size() == 0:
		return

func move_along_path(distance : float, delta) -> void:
	#print(path.size())
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			move_and_slide(((path[0] - global_position)*delta).normalized() * move_speed)
			animationTree.set("parameters/Idle/blend_position", (path[0] - global_position).normalized())
			animationTree.set("parameters/Run/blend_position", (path[0] - global_position).normalized())
			animationState.travel("Run")
			break
		elif distance < 0.0:
			position = path[0]
			animationState.travel("Idle")
#			set_physics_process(false)
			can_move = false
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func get_class():
	return "Alien"
