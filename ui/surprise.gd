extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var texture_rect: TextureRect = $TextureRect
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	timer.start(randf_range(5, 30))


func _on_timeout() -> void:
	audio_stream_player.play()
	var tween = create_tween()
	tween.tween_property(texture_rect, "modulate:a", 1, 0.05)
	tween.tween_property(texture_rect, "modulate:a", 0, 0.15)
	tween.tween_callback(audio_stream_player.stop)
	await tween.finished
	timer.start(randf_range(5, 30))

	
