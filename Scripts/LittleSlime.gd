extends Slime
class_name LittleSlime

@export var fallSounds: Array[AudioStream]

func _ready():
	if(init): SlimeInit()

func SlimeInit():
	isBig = false
	get_parent().AddTileScene("LittleSlime", tilePosition, heightLayer, self)
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
		if(moveDirection != Vector2.ZERO and moveDirection.length() == 1):
			$Behaviour.AttemptMove(moveDirection)

func MoveTiles(dir: Vector2i):
	inGoal = CheckForGoal(tilePosition + dir, heightLayer)
	ChangeTiles(tilePosition + dir)

func CheckFacingTiles(dir: Vector2i) -> Array[String]:
	return [get_parent().ReadTile(tilePosition + dir, heightLayer)]

func CheckForGoal(pos: Vector2i, y: int) -> bool:
	return get_parent().ReadTile(pos, y) == "Goal"

func CheckForExpand() -> bool:
	var checkTile: String
	var slimesInTheWay: int = 0
	for ii in VectorTools.directionVectors:
		checkTile = get_parent().ReadTile(tilePosition + ii, heightLayer)
		if(checkTile == "LittleSlime"):
			slimesInTheWay += 1
		elif(checkTile == "Air" or checkTile == "Goal"):
			pass
		else:
			return false
	return slimesInTheWay == 1

func CheckForGround() -> bool:
	var below: String = get_parent().ReadTile(tilePosition, heightLayer - 1)
	return below != "Air" and below != "Goal"

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

func MergeWith(otherSlime: LittleSlime):
	inControl = false
	SlimeController.RemoveSlime(self, true)
	SlimeController.RemoveSlime(otherSlime, true)
	get_parent().RemoveTileScene(self)
	get_parent().RemoveTileScene(otherSlime)
	SlimeController.UnselectAll()
	
	var combo = [slimeName, otherSlime.slimeName]
	combo.sort()
	var newSlimeScene: PackedScene = load(Slime.slimeComboMap[combo])
	var newSlime: BigSlime = newSlimeScene.instantiate()
	newSlime.isBig = true
	newSlime.composeSlimes = [self, otherSlime]
	get_parent().add_child(newSlime)
	get_parent().AddTileScene("BigSlime", otherSlime.tilePosition, otherSlime.heightLayer, newSlime)
	SlimeController.slimeList.append(newSlime)
	newSlime.ChangeTiles(otherSlime.tilePosition)
	newSlime.heightLayer = otherSlime.heightLayer
	newSlime.DropHeightLayer()
	newSlime.visible = true
	newSlime.inControl = true
	
	visible = false
	otherSlime.visible = false
