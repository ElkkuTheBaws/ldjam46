extends pickable
class_name Enemy

onready var timer = $HitTimer
var MAX_SPEED = 200
#var collision
var HP = 2
var canTakeDamage = true

func _physics_process(_delta: float) -> void:
	if collision:
		if collision.collider is pickable:
			if(collision.collider.inAir and canTakeDamage):
				lose_hp()
				canTakeDamage = false
				print(self.get_class(), " collided with ", collision.collider.get_class())
				timer.start()
	return

func lose_hp() -> void:
	HP -= 1
	if(HP == 0):
		queue_free()
	return

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _on_HitTimer_timeout() -> void:
	canTakeDamage = true
	return
