extends YSort

export(Array, String) var introText

signal say(text, talker)

func _ready() -> void:
	if GlobalVariables.firstTime:
		emit_signal("say", introText, president)
	var music = MusicPlayer.get_node("AudioStreamPlayer")
	if !music.playing:
		music.play()
