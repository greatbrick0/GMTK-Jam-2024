extends Node

var slimeList: Array[Slime]
var keyOrder: Array[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

func _process(delta):
	for ii in range(keyOrder.size()):
		if(Input.is_action_just_pressed("ControlSlime" + keyOrder[ii])):
			if(ii < slimeList.size()):
				UnselectAll()
				slimeList[ii].inControl = true

func UnselectAll():
	for ii in slimeList:
		ii.inControl = false

func RemoveSlime(slime: Slime):
	slimeList.erase(slime)
	if(slimeList.size() <= 0):
		print("You Lose")
	else:
		slimeList[0].set_deferred("inControl", true)

func CheckForVictory():
	for ii in slimeList:
		if(!ii.inGoal):
			return
	print("victory")
