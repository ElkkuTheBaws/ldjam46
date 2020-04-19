extends Node2D

var window_size = Vector2(256,150)
onready var player1 = get_node("../Player")
onready var player_world_pos = get_player_grid_pos()

func _ready():
	OS.set_window_title("HAHA PRESIDENT")
	OS.set_window_size(window_size)
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_world_pos * window_size
	get_viewport().set_canvas_transform(canvas_transform)
	OS.set_window_size(window_size*3)
	
func get_player_grid_pos():
	#Convert the player position in px to his position on the world
	var pos = player1.position
	var x = floor(pos.x / window_size.x)
	var y = floor(pos.y / window_size.y)
	return Vector2(x, y)
	
func _process(_delta):
	update_camera()
	
func update_camera():
	var new_player_grid_pos = get_player_grid_pos()
	var transform = Transform2D()
	if new_player_grid_pos != player_world_pos:
		player_world_pos = new_player_grid_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = -player_world_pos * window_size
		get_viewport().set_canvas_transform(transform)
	return transform
