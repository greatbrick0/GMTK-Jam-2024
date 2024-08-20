extends Node

@export var envStreams: Array[AudioStream]

func _ready():
	$EnvSounds.stream = envStreams[0]
	$EnvSounds.play()
	await get_tree().create_timer(10.0).timeout
	$Track1.play()

func _on_track_timer_timeout():
	$Track1.play()

func _on_env_timer_timeout():
	if(!$Track1.playing):
		$EnvSounds.stream = envStreams.pick_random()
		$EnvSounds.play()
