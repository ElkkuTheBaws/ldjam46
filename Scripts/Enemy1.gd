extends Enemy

export var speed = 200.0
export var min_distance = 300.0
onready var nav_2d : Navigation2D = get_node("../Navigation2D")	
onready var pleijeri = get_node("../Player")	
var path : = PoolVector2Array()
var tplayer : player
var chase = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)


func _physics_process(delta: float) -> void:
#	var direction: = (tplayer.global_position - global_position).normalized()
#	var distance_to_player: = global_position.distance_to(tplayer.global_position)
#	if distance_to_player <= min_distance:
#		collision = move_and_collide(speed * direction * delta)
	var move_distance = (speed * delta)
	if chase:
		calculate_path()
	move_along_path(move_distance, delta)


func _on_PlayerDetector_body_entered(body: Node) -> void:
	if not body is player:
		return
	tplayer = body
	chase = true
	set_physics_process(true)

func calculate_path():
	var new_path = nav_2d.get_simple_path(self.global_position, pleijeri.position)
	path = new_path
	if path.size() == 0:
		return

func move_along_path(distance : float, delta) -> void:
	print(path.size())
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			move_and_slide(((path[0] - global_position)*delta).normalized() * speed)
			break
		elif distance < 0.0:
			position = path[0]
			set_physics_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
