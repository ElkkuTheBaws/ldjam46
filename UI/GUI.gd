extends MarginContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var itemslot = get_node("CenterContainer/Itemslot")

var empty = load("res://Textures/UI/itemslot/empty.png")
var barrel = load("res://Textures/UI/itemslot/barrel.png")
var president = load("res://Textures/UI/itemslot/president.png")
var alien = load("res://Textures/UI/itemslot/alien.png")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_Player_carried_object_changed(object, hasObject) -> void:
	if not hasObject:
		itemslot.texture = empty
	else:
		match (object.get_class()):
			"Barrel":
				itemslot.texture = barrel
			"President":
				itemslot.texture = president
			"Alien":
				itemslot.texture = alien
