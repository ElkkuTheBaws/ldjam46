extends Node2D

signal activated(isActivated, id)
onready var sprite = get_node("Sprite")
var down = load("res://Textures/button/button_down.png")
var up = load("res://Textures/button/button_up.png")

export var id = 0

var amount = 0

func _on_Area2D_body_entered(body: Node) -> void:
	if body is player or body is pickable:
		emit_signal("activated", true, id)
		amount += 1
		sprite.texture = down


func _on_Area2D_body_exited(body: Node) -> void:
	if body is player or body is pickable:
		amount += -1
		if amount == 0:
			emit_signal("activated", false, id)
			sprite.texture = up
