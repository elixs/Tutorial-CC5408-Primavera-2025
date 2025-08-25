extends CharacterBody2D

@export var max_speed = 50
@export var gravity = 400
@export var acceleration = 500

@onready var pivot: Node2D = $Pivot
@onready var ray_cast_2d: RayCast2D = $Pivot/RayCast2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	var move_input = pivot.scale.x
	velocity.x = move_toward(velocity.x, move_input * max_speed, acceleration * delta)
	move_and_slide()
	
	if not ray_cast_2d.is_colliding():
		pivot.scale.x *= -1
	
func take_damage(damage):
	queue_free()
