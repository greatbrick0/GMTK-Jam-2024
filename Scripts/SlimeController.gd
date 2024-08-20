extends Node

const restartPopUp: PackedScene = preload("res://Scenes/restart_pop.tscn")
const keyOrder: Array[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

var slimeList: Array[Slime]
var playerLost: bool = false

func _process(delta):
	if(Input.is_action_just_pressed("Retry")):
		slimeList.clear()
		playerLost = false
		get_tree().reload_current_scene()
	if(Input.is_action_just_pressed("BackToMenu")):
		slimeList.clear()
		playerLost = false
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
	if(playerLost): return
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
		playerLost = true
		var popUp = restartPopUp.instantiate()
		add_child(popUp)
		popUp.get_node("AnimationPlayer").play("SlideUp")

func CheckForVictory():
	if(slimeList.size() <= 0):
		return
	for ii in slimeList:
		if(!ii.inGoal):
			return
	print("victory")
