extends Node

@export var bind: String

func _ready():
	self.pressed.connect(ActivateBind)

func ActivateBind():
	Input.action_press(bind)
