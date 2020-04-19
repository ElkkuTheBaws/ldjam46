extends Node2D

signal activated(isActivated, id)

export var id = 0

var amount = 0

func _on_Area2D_body_entered(body: Node) -> void:
	if body is player or body is pickable:
		emit_signal("activated", true, id)
		amount += 1


func _on_Area2D_body_exited(body: Node) -> void:
	if body is player or body is pickable:
		amount += -1
		if amount == 0:
			emit_signal("activated", false, id)
