extends Node3D
class_name Slime

@export var inControl: bool = true

func _ready():
	pass 

func _process(delta):
	var moveDirection: Vector2 = Vector2.ZERO
	if(Input.is_action_just_pressed("MoveUp")):
		moveDirection = Vector2.UP
	if(Input.is_action_just_pressed("MoveDown")):
		moveDirection = Vector2.DOWN
	if(Input.is_action_just_pressed("MoveLeft")):
		moveDirection = Vector2.LEFT
	if(Input.is_action_just_pressed("MoveRight")):
		moveDirection = Vector2.RIGHT
