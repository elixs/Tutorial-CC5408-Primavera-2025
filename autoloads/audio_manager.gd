extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func start_music():
	if not audio_stream_player.playing:
		audio_stream_player.play()
