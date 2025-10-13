@tool
extends HBoxContainer

@export var data: ItemData:
	set(value):
		data = value
		update()

@onready var quantity: Label = $Quantity
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	update()
	#InventoryManager.inventory_changed.connect(update)


func update() -> void:
	if not data or not is_node_ready():
		return
	texture_rect.texture = data.image
	quantity.text = str(InventoryManager.get_quantity(data))
