class_name Magic
extends Hitbox

@export var max_speed = 300

func _physics_process(delta: float) -> void:
	var velocity = max_speed * transform.x
	position += velocity * delta
