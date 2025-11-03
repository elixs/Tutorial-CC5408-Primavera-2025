extends PanelContainer


func  _process(_delta: float) -> void:
	var screen_size = get_viewport_rect().end
	var mouse_position = get_global_mouse_position()
	global_position.x = max(8, min(mouse_position.x + 8, screen_size.x - size.x - 8))
	global_position.y = max(8, min(mouse_position.y + 8, screen_size.y - size.y - 8))
