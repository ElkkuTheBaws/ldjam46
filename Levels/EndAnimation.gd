extends AnimatedSprite

func _ready():
	play()


func _process(delta):
	if animation == "First":
		if frame >= 80:
			animation = "Second"
			play()
