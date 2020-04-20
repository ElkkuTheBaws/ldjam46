extends Node2D

var window_size = Vector2(256,150)
onready var player1 = get_node("../Player")
onready var player_world_pos = get_player_grid_pos()
onready var center = $Position2D

export var decay_rate = 1
export var max_offset = 5

var _trauma = 0

func _ready():
	randomize()
	OS.set_window_title("HAHA PRESIDENT")
	OS.set_window_size(window_size)
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_world_pos * window_size
	center.position = player_world_pos * window_size
	get_viewport().set_canvas_transform(canvas_transform)
	var _start
	OS.set_window_size(window_size*3)
	
func get_player_grid_pos():
	#Convert the player position in px to his position on the world
	var pos = player1.position
	var x = floor(pos.x / window_size.x)
	var y = floor(pos.y / window_size.y)
	return Vector2(x, y)
	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		add_trauma(500, decay_rate, max_offset)
	update_camera()
	if _trauma > 0:
		_decay_trauma(delta)
		_apply_shake()
	
	
func update_camera():
	var new_player_grid_pos = get_player_grid_pos()
	var transform = Transform2D()
	if new_player_grid_pos != player_world_pos:
		player_world_pos = new_player_grid_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = -player_world_pos * window_size
		transform[1] = Vector2(0, 1)
#		print(transform[2])
		center.position = player_world_pos * window_size
#		print(center.position)
		get_viewport().set_canvas_transform(transform)
	return transform

func add_trauma(amount, decay, offset):
	_trauma = min(_trauma + amount, 1)
	decay_rate = decay
	max_offset = offset
	

func _decay_trauma(delta):
	var charge = decay_rate * delta
	_trauma = max(_trauma - charge, 0)
	
func _apply_shake():
	var shake = _trauma * _trauma
	var o_x = max_offset * shake * _get_neg_or_pos_scalar()
	var o_y = max_offset * shake * _get_neg_or_pos_scalar()
	var transform = get_viewport().get_canvas_transform()
	transform[2] = -player_world_pos * window_size + Vector2(o_x, o_y)
	get_viewport().set_canvas_transform(transform)
	
	
func _get_neg_or_pos_scalar():
	return rand_range(-1.0, 1.0)





func _on_Player_screen_shake(amount, decay, offset):
	add_trauma(amount, decay, offset)
