extends Area2D

@export var magic_strategy: MagicStrategy
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label




func _ready() -> void:
	if magic_strategy:
		sprite_2d.texture = magic_strategy.texture
		label.text = magic_strategy.display_name
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	var player = body as Player
	if player:
		player.magic_strategies.push_back(magic_strategy)
		queue_free()
		
