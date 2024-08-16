extends Node3D
class_name Slime

@export var inControl: bool = true
@export var heightLayer: int = 1
@export var tilePosition: Vector2i = Vector2i.ZERO
var isDead: bool = false

func _ready():
	pass 

func _process(delta):
	if(inControl):
		var moveDirection: Vector2 = Vector2.ZERO
		if(Input.is_action_just_pressed("MoveUp")):
			moveDirection = Vector2.UP
		if(Input.is_action_just_pressed("MoveDown")):
			moveDirection = Vector2.DOWN
		if(Input.is_action_just_pressed("MoveLeft")):
			moveDirection = Vector2.LEFT
		if(Input.is_action_just_pressed("MoveRight")):
			moveDirection = Vector2.RIGHT
			
		$Behaviour.AttemptMove(moveDirection)

func MoveTiles(dir: Vector2):
	position.x += dir.x
	position.z += dir.y
	tilePosition.x += dir.x
	tilePosition.y += dir.y

func CheckForGround() -> bool:
	return get_parent().ReadTile(tilePosition, heightLayer - 1) != "Air"

func DropHeightLayer():
	while(!isDead && !CheckForGround()):
		heightLayer -= 1
		if(heightLayer <= 0):
			Die()

func Die():
	print("dead slime")
	inControl = false
	isDead = true
