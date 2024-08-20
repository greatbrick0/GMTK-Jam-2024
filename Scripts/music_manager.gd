extends Node

@export var envStreams: Array[AudioStream]

func _on_track_timer_timeout():
	$Track1.play()

func _on_env_timer_timeout():
	if(!$Track1.playing):
		$EnvSounds.stream = envStreams.pick_random()
		$EnvSounds.play()
