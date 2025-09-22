class_name GlitterStrategy
extends MagicStrategy

@export var glitter_scene: PackedScene

func apply_strategy(magic: Magic):
	var glitter_inst = glitter_scene.instantiate()
	magic.add_child(glitter_inst)
