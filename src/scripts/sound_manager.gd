class_name SoundManager extends Node

@onready var ambient_audio : AudioStreamPlayer = $AmbientAudio
@onready var rolling_audio : AudioStreamPlayer = $RollingAudio
@onready var hey_audio : AudioStreamPlayer = $HeyAudio
@onready var music_audio : AudioStreamPlayer = $MusicAudio

func _ready() -> void:
	Globals.sound_manager = self

func play_ambient_audio(_play : bool) -> void:
	if ambient_audio.playing:
		if _play:
			return
		else:
			ambient_audio.stream_paused = true
	else:
		if _play:
			if ambient_audio.stream_paused:
				ambient_audio.stream_paused = false
			else:
				ambient_audio.play()
		else:
			ambient_audio.stream_paused = true

func play_music_audio(_play : bool) -> void:
	pass
	#if music_audio.playing:
		#if _play:
			#return
		#else:
			#music_audio.stream_paused = true
	#else:
		#if _play:
			#if music_audio.stream_paused:
				#music_audio.stream_paused = false
			#else:
				#music_audio.play()
		#else:
			#music_audio.stream_paused = true

func play_rolling_audio(_play : bool) -> void:
	rolling_audio.playing = _play

func play_hey_audio() -> void:
	hey_audio.play()
