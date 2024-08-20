extends Node

@export var bind: String

func _ready():
	self.pressed.connect(ActivateBind)

func ActivateBind():
	print(bind)
	Input.action_press(bind, 1.0)
	Input.call_deferred("action_release", bind)
