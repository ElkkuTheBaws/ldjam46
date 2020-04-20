extends RichTextLabel
#
#export(Array, String) var dialog
#var page = 0
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	set_text(dialog[0])
#	set_visible_characters(0)
#	set_process_input(true)
#
#
#
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_accept"):
#		if get_visible_characters() > get_total_character_count():
#			if page == dialog.size() -1:
#				get_parent().queue_free()
#			if page < dialog.size() - 1:
#				page += 1
#				set_text(dialog[page])
#				set_visible_characters(0)
#		else:
#			set_visible_characters(get_total_character_count())
#
#
#func _on_Timer_timeout() -> void:
#	set_visible_characters(get_visible_characters() + 1)
#
