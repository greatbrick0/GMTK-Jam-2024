extends Node

@export var newScene: PackedScene

func _ready():
	self.button_down.connect(LoadScene)

func LoadScene():
	get_tree().change_scene_to_packed(newScene)
