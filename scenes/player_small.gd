extends Player


func _ready() -> void:
	super._ready()
	Debug.log("player small ready", 20)

	#sprite_2d.modulate = Color.BLUE

func can_jump() -> bool:
	return false
