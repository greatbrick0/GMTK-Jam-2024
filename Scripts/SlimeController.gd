extends Node

var slimeList: Array[Slime]
const keyOrder: Array[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

func _process(delta):
	if(Input.is_action_just_pressed("Retry")):
		
		slimeList.clear()
		get_tree().reload_current_scene()
	if(Input.is_action_just_pressed("BackToMenu")):
		slimeList.clear()
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
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
		if(slimeList.size() <= 0):
			print("You Lose")
		else:
			slimeList[0].set_deferred("inControl", true)

func CheckForVictory():
	if(slimeList.size() <= 0):
		return
	for ii in slimeList:
		if(!ii.inGoal):
			return
	print("victory")
