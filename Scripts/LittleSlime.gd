extends Slime
class_name LittleSlime

@export var fallSounds: Array[AudioStream]

func _ready():
	isBig = false
	get_parent().AddTileScene("LittleSlime", tilePosition, heightLayer, self)
	SlimeController.slimeList.append(self)

func _process(delta):
	$Visuals/ControlRing.visible = inControl
	
	if(Input.is_action_just_pressed("PuzzleAction")):
		$Visuals/SlimeBody/SlimeAnim.play("RESET")
		$MovePlayer.play("RESET")
		$Visuals.position = Vector3.ZERO
	
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
		if(moveDirection != Vector2.ZERO):
			$Behaviour.AttemptMove(moveDirection)

func MoveTiles(dir: Vector2i):
	inGoal = CheckForGoal(tilePosition + dir, heightLayer)
	ChangeTiles(tilePosition + dir)

func CheckFacingTiles(dir: Vector2i) -> Array[String]:
	return [get_parent().ReadTile(tilePosition + dir, heightLayer)]

func CheckForGoal(pos: Vector2i, y: int) -> bool:
	return get_parent().ReadTile(pos, y) == "Goal"

func CheckForExpand(pos: Vector2i, y: int) -> bool:
	var checkTile: String
	var slimesInTheWay: int = 0
	for ii in VectorTools.directionVectors:
		checkTile = get_parent().ReadTile(pos + ii, y)
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
	$Visuals.visible = false
	get_parent().tileScenes.erase(self)
	SlimeController.RemoveSlime(self)
	$Sounds/FallSound.stream = fallSounds.pick_random()
	$Sounds/FallSound.play()
