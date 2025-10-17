class_name PlayerTopDown
extends CharacterBody2D


@export var max_speed = 300
@export var acceleration = 500

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/movement/playback"]
@onready var pivot: Node2D = $Pivot


	
func _physics_process(delta: float) -> void:
	
	var move_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if animation_tree["parameters/attack/active"]:
		move_input = Vector2.ZERO
	
	
	velocity = velocity.move_toward(move_input * max_speed, acceleration * delta)
	
	
	
	move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		var attack_direction = global_position.direction_to(get_global_mouse_position())
		animation_tree["parameters/attack_blend_space/blend_position"] = attack_direction
		animation_tree["parameters/attack/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		move_input = Vector2.ZERO
		pivot.scale.x = sign(attack_direction.x)
	
	
	# animation
	if move_input.x:
		pivot.scale.x = sign(move_input.x)
	
	
	var speed = velocity.length()
	if move_input or speed > 10:
		playback.travel("run")
	else:
		playback.travel("idle")
	
	animation_tree["parameters/movement/run/time_scale/scale"] = speed / (max_speed * 0.5)

func take_damage(_damage):
	Debug.log("Auch player")
