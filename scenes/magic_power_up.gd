@tool
extends Area2D

@export var magic_strategy: MagicStrategy:
	set(value):
		magic_strategy = value
		update()
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label


func _ready() -> void:
	update()
	body_entered.connect(_on_body_entered)


func update():
	if not magic_strategy or not sprite_2d or not label:
		return
	sprite_2d.texture = magic_strategy.texture
	label.text = magic_strategy.display_name

func _on_body_entered(body: Node2D):
	var player = body as Player
	if player:
		player.magic_strategies.push_back(magic_strategy)
		queue_free()
		
