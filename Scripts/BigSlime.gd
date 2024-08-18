extends Slime
class_name BigSlime

@export var fallSounds: Array[AudioStream]

func _ready():
	isBig = true
	get_parent().AddTileScene("BigSlime", tilePosition, heightLayer, self)
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
