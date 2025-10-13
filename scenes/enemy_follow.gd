extends CharacterBody2D

enum State {
	WANDERING,
	FOLLOWING
}


@export var speed: int = 50
@export var acceleration: int = 1000


var _target: PlayerTopDown = null
var state = State.WANDERING:
	set = set_state
var _wandering_radius = 300


@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var follow_area: Area2D = $FollowArea
@onready var unfollow_area: Area2D = $UnfollowArea
@onready var path_timer: Timer = $PathTimer


func _ready() -> void:
	follow_area.body_entered.connect(_on_detection_body_entered)
	unfollow_area.body_exited.connect(_on_detection_body_exited)
	path_timer.timeout.connect(update_target_position)
	
	
	set_state(State.WANDERING)

func _physics_process(delta: float) -> void:
	match state:
		State.WANDERING:
			_wandering(delta)
		State.FOLLOWING:
			_following(delta)



func _wandering(delta: float) -> void:
	if navigation_agent_2d.is_navigation_finished():
		choose_next_wandering_target()
	else:
		var new_pos = navigation_agent_2d.get_next_path_position()
		var direction = global_position.direction_to(new_pos)
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
		move_and_slide()


func _following(delta: float) -> void:
	if not _target:
		return
		
	
	if navigation_agent_2d.is_navigation_finished():
		return
	
	var new_pos = navigation_agent_2d.get_next_path_position()
	var direction = global_position.direction_to(new_pos)
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	move_and_slide()

func _on_detection_body_entered(body: Node):
	var player = body as PlayerTopDown
	if player:
		_target = player
		path_timer.start()


func _on_detection_body_exited(body: Node):
	if body == _target:
		_target = null
		path_timer.stop()


func update_target_position():
	if _target:
		navigation_agent_2d.target_position = _target.global_position


func choose_next_wandering_target():
	var new_target = global_position + Vector2(randf_range(-1, 1), randf_range(-1, 1)) * _wandering_radius
	# TODO check if new target has navigation data
	navigation_agent_2d.target_position = new_target
	

func set_state(new_state):
	match new_state:
		State.WANDERING:
			choose_next_wandering_target()
	
	state = new_state
