extends Node

@export var _audio_stream_player: AudioStreamPlayer

func _ready():
	_set_audio_level()
	EventBus.music_volume_changed.connect(_set_audio_level)

func _set_audio_level():
	if (SaveManager.has_save_data("music_volume")):
		_audio_stream_player.volume_db = linear_to_db(SaveManager.retrieve_save_data("music_volume") / 100.0)
