class_name DamageStrategy
extends MagicStrategy

@export var damage: int = 10


func apply_strategy(magic: Magic):
	magic.damage += damage
