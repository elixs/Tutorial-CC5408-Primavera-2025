extends StaticBody2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func take_damage(damage):
	Debug.log("Auch %d" % damage)
	audio_stream_player.play()
