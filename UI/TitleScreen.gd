extends Control

onready var animation = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OS.window_size = Vector2(256*3,150*3)
	animation.play()
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_pick"):
		get_tree().change_scene("res://Levels/Level0.tscn")
		
	if Input.is_action_just_pressed("Close"):
		get_tree().quit()
