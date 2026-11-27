extends Node

var music_player: AudioStreamPlayer

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	
func play_music(stream: AudioStream) -> void:
	if music_player.stream == stream and music_player.playing:
		return
		
	music_player.stream = stream
	music_player.play()
	
	
func stop_music() -> void:
	music_player.stop()
	
	
func play_sfx(stream: AudioStream) -> void:
	var sfx_player: AudioStreamPlayer =  AudioStreamPlayer.new()
	sfx_player.stream = stream
	add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)
	
