extends Node

@export var fallSounds: Array[AudioStream]
@export var moveSounds: Array[AudioStream]

func PlayFallSound():
	$FallSound.stream = fallSounds.pick_random()
	$FallSound.play()

func PlayMoveSound():
	$MoveSound.stream = moveSounds.pick_random()
	$MoveSound.play()
