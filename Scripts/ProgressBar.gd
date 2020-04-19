extends ProgressBar


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false;
	min_value = get_parent().min_throw_distance
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Player_throw_length_changed(length) -> void:
	if(length > get_parent().min_throw_distance):
		visible = true
		value = length
		timer.stop()
		timer.start(1)


func _on_Timer_timeout() -> void:
	visible = false
	value = 10
