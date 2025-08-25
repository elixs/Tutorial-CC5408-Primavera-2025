extends Node2D

#@onready var player: Player = $Player
@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	#player.jumped.connect(_on_player_jumped)
	area_2d.body_entered.connect(_on_body_entered)
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.queue_free()
	AudioManager.start_music()
	

func _on_player_jumped(value):
	Debug.log("player jumped")
	Debug.log(value)

func _on_body_entered(body: Node2D):
	Debug.log("entro: %s" % body.name)
	if body is Player:
		Debug.log("is a player")
	if body.is_in_group("players"):
		Debug.log("in group players")
	
