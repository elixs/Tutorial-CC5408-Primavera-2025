extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func start_music():
	if not audio_stream_player.playing:
		audio_stream_player.play()

func play_sfx(stream: AudioStream):
	if not stream:
		return
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.stream = stream
	audio_stream_player.play()
	await audio_stream_player.finished
	audio_stream_player.queue_free()
