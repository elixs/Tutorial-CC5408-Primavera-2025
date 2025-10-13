class_name Player
extends CharacterBody2D

signal jumped

@export var max_speed = 300
@export var jump_speed = 200
@export var gravity = 400
@export var acceleration = 500
@export var dust_particles_scene: PackedScene
@export var magic_scene: PackedScene

var was_on_floor = false
var magic_strategies: Array[MagicStrategy]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/movement/playback"]
@onready var pivot: Node2D = $Pivot
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var floor_ray_cast: RayCast2D = $FloorRayCast
@onready var blink_timer: Timer = $BlinkTimer
@onready var dust_spawn: Marker2D = $DustSpawn
@onready var magic_spawn: Marker2D = $MagicSpawn
@onready var hud: HUD = $HUD
@onready var health_component: HealthComponent = $HealthComponent


func _ready() -> void:
	Debug.log("player ready", 20)
	coyote_timer.timeout.connect(_on_coyote_timeout)
	go_to_next_level()
	blink_timer.timeout.connect(_on_blink_timer)
	hud.setup(health_component)


func go_to_next_level():
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://scenes/main2.tscn")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if (is_on_floor() or not coyote_timer.is_stopped()) and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		jumped.emit(42)
		was_on_floor = false
		Game.points += 1
	
	var move_input = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, move_input * max_speed, acceleration * delta)
	move_and_slide()
	
	if Input.is_action_just_pressed("attack") and not animation_tree["parameters/attack/active"]:
		animation_tree["parameters/attack/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	
	if Input.is_action_just_pressed("magic") and not animation_tree["parameters/magic/active"]:
		var direction = sign(get_global_mouse_position().x - magic_spawn.global_position.x)
		if direction:
			pivot.scale.x = direction
		animation_tree["parameters/magic/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	
	if was_on_floor and not is_on_floor():
		coyote_timer.start()
	if is_on_floor():
		coyote_timer.stop()
	
	if is_on_floor() and not was_on_floor:
		spawn_dust()
	
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


func take_damage(_damage):
	Debug.log("Auch player")


func _on_coyote_timeout():
	pass


func _on_blink_timer():
	animation_tree["parameters/movement/idle/idle_blink/transition_request"] = "blink"
	blink_timer.start(randf_range(1,2))

func spawn_dust():
	if not dust_particles_scene:
		return
	var dust_particles_inst = dust_particles_scene.instantiate()
	add_child(dust_particles_inst)
	dust_particles_inst.global_position = dust_spawn.global_position

func spawn_magic():
	if not magic_scene:
		return
	var magic_inst = magic_scene.instantiate()
	get_parent().add_child(magic_inst)
	magic_inst.global_position = magic_spawn.global_position
	magic_inst.global_rotation = magic_spawn.global_position.direction_to(get_global_mouse_position()).angle()
	for magic_strategy in magic_strategies:
		magic_strategy.apply_strategy(magic_inst)
