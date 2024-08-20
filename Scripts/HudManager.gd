extends CanvasLayer

@export var winSounds: Array[AudioStream]

func _process(delta):
	if(SlimeController.slimeList.size() > 1):
		$Control/ControlButtons.visible = true
		for ii in range($Control/ControlButtons.get_children().size()):
			$Control/ControlButtons.get_children()[ii].visible = SlimeController.slimeList.size() > ii
	else:
		$Control/ControlButtons.visible = false

func FadeOut():
	$FadePlayer.play("FadeOut")
	await $FadePlayer.animation_finished

func FadeIn():
	$FadePlayer.play("FadeIn")
	await $FadePlayer.animation_finished

func PlayWinSound():
	print("win")
	$WinSound.stream = winSounds.pick_random()
	$WinSound.play()
