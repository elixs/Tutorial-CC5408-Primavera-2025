class_name HealthComponent
extends Node

signal health_changed(value)
signal died

@export var health: int = 100:
	set(value):
		health = clamp(value, 0, max_health)
		health_changed.emit(health)
		if health == 0:
			died.emit()
@export var max_health: int = 100
