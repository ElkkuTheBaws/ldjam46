extends Enemy

var speed = 200.0
var min_distance = 300.0


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
