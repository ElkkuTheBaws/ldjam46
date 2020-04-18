extends Enemy

export var speed = 200.0
export var min_distance = 300.0
onready var nav_2d : Navigation2D = get_node("../Navigation2D")	
var tplayer : player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_physics_process(false)
	return


func _physics_process(delta: float) -> void:
	var direction: = (tplayer.global_position - global_position).normalized()
	var distance_to_player: = global_position.distance_to(tplayer.global_position)
	if distance_to_player <= min_distance:
		collision = move_and_collide(speed * direction * delta)
	
	return


func _on_PlayerDetector_body_entered(body: Node) -> void:
	if not body is player:
		return
	tplayer = body
	set_physics_process(true)
	return

func make_path():
	var new_path : = nav_2d.get_simple_path(self.global_position, player.position) #player.pos ei pakolla toimi
	if new_path.size() == 0:
		return
	set_physics_process(true)
	
#func move_along_path(distance : float, path) -> void:
#	var start_point : = position
#	for i in range(path.size()):
#		var distance_to_next : = start_point.distance_to(path[0])
#		if distance <= distance_to_next and distance >= 0.0:
#			position = start_point.linear_interpolate()
