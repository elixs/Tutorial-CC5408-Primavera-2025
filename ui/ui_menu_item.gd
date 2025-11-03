extends PanelContainer

@onready var ui_tooltip: PanelContainer = %UITooltip
@onready var ui_tooltip_parent: Control = $UITooltipParent

func _ready() -> void:
	pass
	ui_tooltip.hide()
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)



func _on_mouse_entered() -> void:
	ui_tooltip.show()

func _on_mouse_exited() -> void:
	ui_tooltip.hide()
	
