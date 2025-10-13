class_name HUD
extends CanvasLayer
@onready var health_bar: ProgressBar = %HealthBar
@onready var coins: Label = %Coins


func _ready() -> void:
	Game.coins_changed.connect(update_coins)
	update_coins(Game.coins)


func setup(health_component: HealthComponent):
	health_bar.value = health_component.health
	health_bar.max_value = health_component.max_health
	health_component.health_changed.connect(_on_health_changed)


func _on_health_changed(value):
	health_bar.value = value


func update_coins(value):
	coins.text = str(value)
