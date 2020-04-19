extends RayCast2D


onready var player: = get_parent()

func _physics_process(_delta: float) -> void:
	enabled = true
	#cast_to = player.current_direction.normalized()*10
	
	if is_colliding():
		player.throw_destination = get_collision_point()
	else:
		player.throw_destination = global_position + player.current_direction.normalized()*50


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Player_throw_length_changed(length) -> void:
	if (length > 75):
		cast_to = player.current_direction.normalized()*75
	else:
		cast_to = player.current_direction.normalized()*length
