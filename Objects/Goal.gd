extends KinematicBody2D


export var next_level = 1
export (Array, String) var dialog
signal say(dialog, talker)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#func _physics_process(_delta: float) -> void:
	


func _on_Area2D_body_entered(body: Node) -> void:
	if body is player:
		if body.hasObject and body.picked.get_class() == "President":
			get_tree().change_scene("res://Levels/Level"+ str(next_level)+ ".tscn")
		else:
			emit_signal("say", dialog, player)
