extends TextureRect


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var empty = load("res://Textures/UI/itemslot/empty.png")
var barrel = load("res://Textures/UI/itemslot/barrel.png")
var president = load("res://Textures/UI/itemslot/president.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = empty


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Player_carried_object_changed(object, hasObject) -> void:
	if not hasObject:
		texture = empty
	else:
		match (object.get_class()):
			"Barrel":
				texture = barrel
			president:
				texture = president
