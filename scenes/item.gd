@tool
class_name Item
extends Area2D

@export var data: ItemData:
	set(value):
		data = value
		update()

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label


func _ready() -> void:
	update()
	body_entered.connect(_on_body_entered)


func update() -> void:
	if not data or not is_node_ready():
		return
	sprite_2d.texture = data.image
	label.text = data.display_name


func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if player:
		InventoryManager.pickup(data)
		queue_free()
