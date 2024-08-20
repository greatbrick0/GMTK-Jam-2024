extends Node
class_name WinSceneHolder

@export var winScene: PackedScene

func _ready():
	SlimeController.winScene = winScene
