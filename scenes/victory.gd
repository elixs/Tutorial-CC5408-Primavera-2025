extends Area2D

@onready var confetti: GPUParticles2D = $Confetti

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if player:
		confetti.emitting = true
		player.set_physics_process(false)
