extends StaticBody2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var timer: Timer = $Timer

func _ready() -> void:
	pass
	#timer.timeout.connect(_on_timer_timeout)
	
	
func take_damage(damage):
	Debug.log("Auch %d" % damage)
	audio_stream_player.play()


func _on_timer_timeout():
	Debug.log(Game.coins)
