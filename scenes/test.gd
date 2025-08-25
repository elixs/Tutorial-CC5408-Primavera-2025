extends Node2D


@export var meh: bool = true
@export var speed: float = 300.5
@export var ball_scene: PackedScene

@onready var spawn_point: Marker2D = $Node2D/SpawnPoint


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		print("open menu")


func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		if ball_scene:
			var ball_inst = ball_scene.instantiate()
			add_child(ball_inst)
			ball_inst.global_position = get_global_mouse_position()
		else:
			print("missing scene")
