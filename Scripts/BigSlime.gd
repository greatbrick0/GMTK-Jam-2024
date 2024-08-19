extends Slime
class_name BigSlime

@export var composeSlimes: Array[LittleSlime] = []
@export var fallSounds: Array[AudioStream]

func _ready():
	if(init): SlimeInit()

func SlimeInit():
	isBig = true
	get_parent().AddTileScene("BigSlime", tilePosition, heightLayer, self)
	SlimeController.slimeList.append(self)
	visible = true

func _process(delta):
	$VisualsOffset/Visuals/ControlRing.visible = inControl
	
	for ii in puzzleActionList:
		if(Input.is_action_just_pressed(ii)):
			$AnimQueue.SkipQueue()
	
	if(inControl):
		var moveDirection: Vector2 = Vector2.ZERO
		if(Input.is_action_just_pressed("MoveUp")):
			moveDirection += Vector2.UP
		if(Input.is_action_just_pressed("MoveDown")):
			moveDirection += Vector2.DOWN
		if(Input.is_action_just_pressed("MoveLeft")):
			moveDirection += Vector2.LEFT
		if(Input.is_action_just_pressed("MoveRight")):
			moveDirection += Vector2.RIGHT
		if(Input.is_action_just_pressed("Split")):
			Split()
		if(moveDirection != Vector2.ZERO and moveDirection.length() == 1):
			$Behaviour.AttemptMove(moveDirection)

func MoveTiles(dir: Vector2i):
	inGoal = CheckForGoal(tilePosition + dir, heightLayer)
	ChangeTiles(tilePosition + dir)

func CheckFacingTiles(dir: Vector2i) -> Array[String]:
	var perpDir: Vector2i = VectorTools.Perpendicular(dir)
	var output: Array[String] = []
	output.append(get_parent().ReadTile(tilePosition + dir + dir, heightLayer))
	output.append(get_parent().ReadTile(tilePosition + dir + dir + perpDir, heightLayer))
	output.append(get_parent().ReadTile(tilePosition + dir + dir - perpDir, heightLayer))
	return output

func CheckForGoal(pos: Vector2i, y: int) -> bool:
	if(get_parent().ReadTile(pos, y) == "Goal"):
		return true
	for ii in VectorTools.directionVectors:
		if(get_parent().ReadTile(pos + ii, y) == "Goal"):
			return true
	return false

func CheckForGround() -> bool:
	var below: String
	for ii in range(-1, 2):
		for jj in range(-1, 2):
			below = get_parent().ReadTile(tilePosition + Vector2i(ii, jj), heightLayer - 1)
			if(below != "Air" and below != "Goal"):
				return true
	return false

func DropHeightLayer() -> int:
	var distance: int = 0
	position.y = heightLayer - 1
	while(!isDead && !CheckForGround()):
		inGoal = CheckForGoal(tilePosition, heightLayer - 1)
		heightLayer -= 1
		distance += 1
		get_parent().MoveTileScene(self, tilePosition, heightLayer)
		position.y = heightLayer - 1
		if(heightLayer <= 0):
			Die()
	return distance

func Die():
	print("dead slime")
	inControl = false
	isDead = true
	get_parent().RemoveTileScene(self)
	SlimeController.RemoveSlime(self)
	$Sounds/FallSound.stream = fallSounds.pick_random()
	$Sounds/FallSound.play()

func Split():
	inControl = false
	get_parent().RemoveTileScene(self)
	SlimeController.RemoveSlime(self, true)
	SlimeController.UnselectAll()
	
	get_parent().AddTileScene("LittleSlime", tilePosition, heightLayer, composeSlimes[0])
	SlimeController.slimeList.append(composeSlimes[0])
	composeSlimes[0].ChangeTiles(tilePosition + Vector2i.LEFT)
	composeSlimes[0].heightLayer = heightLayer
	composeSlimes[0].DropHeightLayer()
	composeSlimes[0].visible = true
	composeSlimes[0].inControl = true
	
	get_parent().AddTileScene("LittleSlime", tilePosition, heightLayer, composeSlimes[1])
	SlimeController.slimeList.append(composeSlimes[1])
	composeSlimes[1].ChangeTiles(tilePosition + Vector2i.RIGHT)
	composeSlimes[1].heightLayer = heightLayer
	composeSlimes[1].DropHeightLayer()
	composeSlimes[1].visible = true
	
	visible = false
