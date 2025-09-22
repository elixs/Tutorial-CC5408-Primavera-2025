class_name SpeedStrategy
extends MagicStrategy

@export var speed: int = 100


func apply_strategy(magic: Magic):
	magic.max_speed += speed
