extends Sprite

onready var raycast = $RayCast2D
onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false





func _on_Player_throw_length_changed(length) -> void:
	if player.charging:
		visible = true
		global_position = get_parent().global_position + raycast.cast_to
	else:
		visible = false
