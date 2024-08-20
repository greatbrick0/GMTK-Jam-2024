extends CanvasLayer

func FadeOut():
	$FadePlayer.play("FadeOut")
	await $FadePlayer.animation_finished

func FadeIn():
	$FadePlayer.play("FadeIn")
	await $FadePlayer.animation_finished
