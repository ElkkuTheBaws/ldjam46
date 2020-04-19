extends Sprite

onready var raycast = get_node("../RayCast2D")
onready var player = get_parent()
onready var timer = get_node("Timer2")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false





func _on_Player_throw_length_changed(length) -> void:
	if player.charging:
		visible = true
		global_position = get_parent().global_position + raycast.cast_to
		timer.stop()
		timer.start()


func _on_Timer2_timeout() -> void:
	visible = false
