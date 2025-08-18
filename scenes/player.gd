class_name Player
extends CharacterBody2D

signal jumped

@export var max_speed = 300
@export var jump_speed = 200
@export var gravity = 400

@export var acceleration = 500

var was_on_floor = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/movement/playback"]
@onready var pivot: Node2D = $Pivot
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var floor_ray_cast: RayCast2D = $FloorRayCast

func _ready() -> void:
	Debug.log("player ready", 20)
	coyote_timer.timeout.connect(_on_coyote_timeout)

	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if (is_on_floor() or not coyote_timer.is_stopped()) and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		jumped.emit(42)
		was_on_floor = false
	
	var move_input = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, move_input * max_speed, acceleration * delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") and not animation_tree["parameters/attack/active"]:
		animation_tree["parameters/attack/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	
	if floor_ray_cast.is_colliding():
		Debug.log("floor")
	else:
		Debug.log("not floor")
		
	
	if was_on_floor and not is_on_floor():
		coyote_timer.start()
	if is_on_floor():
		coyote_timer.stop()
	
	was_on_floor = is_on_floor()
	
	# animation
	if move_input:
		pivot.scale.x = sign(move_input)
	
	if is_on_floor():
		if move_input or abs(velocity.x) > 10:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")

func can_jump() -> bool:
	return true

func take_damage(damage):
	Debug.log("Auch player")

func _on_coyote_timeout():
	Debug.log("coyote timeout")
