extends Panel

var spritePresident = load("res://Textures/UI/itemslot/president.png")

export(Array, String) var dialog
onready var textLabel = get_node("RichTextLabel")
onready var timer = get_node("Timer")
onready var sprite = get_node("Sprite")
var page = 0
var talking = false
var wait = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	timer.stop()

func reset():
	page = 0
	wait = true
	visible = 0
	timer.stop()
	dialog = null
	talking = false
	set_process_input(false)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_pick"):
		if textLabel.get_visible_characters() > textLabel.get_total_character_count():
			if page == dialog.size() -1:
				reset()
				get_tree().paused = false
			if talking and not dialog == null and page < dialog.size() - 1:
				page += 1
				textLabel.set_text(dialog[page])
				textLabel.set_visible_characters(0)
		else:
			textLabel.set_visible_characters(textLabel.get_total_character_count())


func _on_Timer_timeout() -> void:
	textLabel.set_visible_characters(textLabel.get_visible_characters() + 1)
	


func _on_say(textdialog, talker) -> void:
	if not talking:
		if wait:
			wait = false
			return
		dialog = textdialog
		if talker.get_class() == "President":
			sprite.texture = spritePresident
		visible = true
		textLabel.set_text(dialog[0])
		textLabel.set_visible_characters(0)
		set_process_input(true)
		talking = true
		timer.start()
		get_tree().paused = true
