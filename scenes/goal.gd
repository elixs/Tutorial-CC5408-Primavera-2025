extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D):
	var player = body as Player
	if player:
		TransitionManager.fade(LevelManager.go_next_level)
