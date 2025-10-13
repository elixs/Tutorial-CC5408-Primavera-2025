class_name UIInventory
extends VBoxContainer

@export var ui_item_scene: PackedScene

func _ready() -> void:
	InventoryManager.inventory_changed.connect(reset)


func reset() -> void:
	for child in get_children():
		child.queue_free()

	for id in InventoryManager.inventory.keys():
		var item_data = InventoryManager.library[id]
		var ui_item_inst = ui_item_scene.instantiate()
		ui_item_inst.data = item_data
		add_child(ui_item_inst)
