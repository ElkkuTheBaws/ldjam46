extends pickable
class_name president

signal say(dialog, talker)
signal dead(text, talker)
onready var killArea = get_node("Area2D")
onready var dialogbox = get_node("../CanvasLayer/DialogBox")

export(Array, String) var dialog

func get_class():
	return "President"
	
func talk():
	if dialog.size() == 0:
		return
	emit_signal("say",dialog, self)
	


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Enemy:
		emit_signal("dead", ["AAAAAAAAAAAAAAAAAAAAAAAAAAAH! They got me!", "Maybe you should try again a bit harder?"], self)
		yield(dialogbox,"talking_finished")
		get_tree().reload_current_scene()
