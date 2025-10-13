class_name HealingItemData
extends ItemData

@export var amount: int = 0

func use(player: Player) -> void:
	player.heal(amount)
