extends pickable
class_name president

signal say(dialog, talker)

export(Array, String) var dialog

func get_class():
	return "President"
	
func talk():
	if dialog.size() == 0:
		return
	emit_signal("say",dialog, self)
	
