extends Node2D

@export var death_sound: AudioStream

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var collision_shape_2d: CollisionShape2D = $Hurtbox/CollisionShape2D

func _ready() -> void:
	health_component.died.connect(_on_died)
	

func _on_died():
	hide()
	collision_shape_2d.set_deferred("disabled", true)
	AudioManager.play_sfx(death_sound)
	queue_free()
