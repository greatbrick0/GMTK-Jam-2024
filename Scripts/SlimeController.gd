extends Node

const restartPopUp: PackedScene = preload("res://Scenes/restart_pop.tscn")
const victoryPopUp: PackedScene = preload("res://Scenes/victory_pop.tscn")
const keyOrder: Array[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

var slimeList: Array[Slime]
var playerLost: bool = false
var playerWon: bool = false
var winScene: PackedScene

func _process(delta):
	if(Input.is_action_just_pressed("Retry")):
		await ExitScene()
		get_tree().reload_current_scene()
		HudManager.FadeIn()
	if(Input.is_action_just_pressed("BackToMenu")):
		await ExitScene()
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		HudManager.FadeIn()
	
	if(playerLost or playerWon): return
	for ii in range(keyOrder.size()):
		if(Input.is_action_just_pressed("ControlSlime" + keyOrder[ii])):
			if(ii < slimeList.size()):
				UnselectAll()
				slimeList[ii].inControl = true

func UnselectAll():
	for ii in slimeList:
		ii.inControl = false

func RemoveSlime(slime: Slime, newSlime: bool = false):
	slimeList.erase(slime)
	if(!newSlime):
		Lose()

func CheckForVictory() -> bool:
	if(slimeList.size() <= 0 or playerLost):
		return false
	for ii in slimeList:
		if(!ii.inGoal):
			return false
	Win()
	return true

func ExitScene(clearWinScene: bool = true):
	slimeList.clear()
	playerLost = false
	playerWon = false
	if(clearWinScene): winScene = null
	await HudManager.FadeOut()
	for ii in get_children():
		ii.queue_free()

func Lose():
	playerLost = true
	UnselectAll()
	var popUp = restartPopUp.instantiate()
	add_child(popUp)
	popUp.get_node("AnimationPlayer").play("SlideUp")

func Win():
	playerWon = true
	UnselectAll()
	var popUp = victoryPopUp.instantiate()
	add_child(popUp)
	popUp.get_node("AnimationPlayer").play(["Win1", "Win2", "Win3"].pick_random())
	HudManager.PlayWinSound()
	await get_tree().create_timer(2.0).timeout
	await ExitScene(false)
	if(winScene != null):
		get_tree().change_scene_to_packed(winScene)
	else:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	HudManager.FadeIn()
