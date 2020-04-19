extends Area2D


export var id = 0
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_Pressureplate_activated(isActivated, id) -> void:
	if self.id == id:
		if isActivated:
			open_door()
		else:
			close_door()


func open_door():
	print("aukesi id: ", id)
	
func close_door():
	print("meni kiinni id: ", id)
