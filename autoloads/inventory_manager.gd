extends Node

signal inventory_changed
signal item_1_changed
signal item_2_changed

@export var library: Dictionary[String, ItemData]

# {"potion": quantity}
var inventory: Dictionary = {}

var item_1: ItemData:
	set(value):
		item_1 = value
		item_1_changed.emit()
var item_2: ItemData:
	set(value):
		item_2 = value
		item_2_changed.emit()

func pickup(item_data: ItemData) -> void:
	if not inventory.has(item_data.id):
		inventory[item_data.id] = 0
	for id in inventory.keys():
		if item_data.id == id:
			inventory[id] += 1
			inventory_changed.emit()
			break

func drop(item_data: ItemData) -> void:
	if not inventory.has(item_data.id):
		return
	for id in inventory.keys():
		if item_data.id == id:
			inventory[id] -= 1
			if inventory[id] == 0:
				inventory.erase(id)
			inventory_changed.emit()

func get_quantity(item_data: ItemData) -> int:
	for id in inventory.keys():
		if item_data.id == id:
			return inventory[id]
	return 0
