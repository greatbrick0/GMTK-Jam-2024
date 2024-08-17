extends Node3D
class_name Slime

@export var inControl: bool = true
@export var heightLayer: int = 1
@export var tilePosition: Vector2i = Vector2i.ZERO
var isDead: bool = false

@export var fallSounds: Array[AudioStream]

func _ready():
	get_parent().tileScenes[self] = [tilePosition, heightLayer, "LittleSlime"]

func _process(delta):
	if(Input.is_action_just_pressed("PuzzleAction")):
		$Visuals/TestSlime2/AnimationPlayer.stop()
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

func ChangeTiles(newPos: Vector2i):
	tilePosition = newPos
	get_parent().tileScenes[self][0] = tilePosition
	$Visuals/TestSlime2/AnimationPlayer.play("Green_Move1")

func MoveTiles(dir: Vector2i):
	if(get_parent().ReadTile(tilePosition + dir, heightLayer) == "Air"):
		ChangeTiles(tilePosition + dir)
		position.x += dir.x
		position.z += dir.y

func CheckForGround() -> bool:
	return get_parent().ReadTile(tilePosition, heightLayer - 1) != "Air"

func DropHeightLayer():
	while(!isDead && !CheckForGround()):
		heightLayer -= 1
		get_parent().tileScenes[self][1] = heightLayer
		position.y = heightLayer - 1
		if(heightLayer <= 0):
			Die()

func Die():
	print("dead slime")
	inControl = false
	isDead = true
	$Visuals.visible = false
	get_parent().tileScenes.erase(self)
	$Sounds/FallSound.stream = fallSounds.pick_random()
	$Sounds/FallSound.play()
