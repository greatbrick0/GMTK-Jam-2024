extends Node3D

@export var heightLayer: int = 1
@export var tilePosition: Vector2i = Vector2i.ZERO
@export var breakSounds: Array[AudioStream]
@export var visualsType: int = 0

func _ready():
	BreakableInit()

func BreakableInit():
	for ii in $Visuals.get_child_count():
		$Visuals.get_child(ii).visible = ii == visualsType
	get_parent().AddTileScene("Box", tilePosition, heightLayer, self)
	visible = true
	ChangeTiles(tilePosition)

func ChangeTiles(newPos: Vector2i):
	tilePosition = newPos
	get_parent().MoveTileScene(self, tilePosition, heightLayer)
	position.x = newPos.x
	position.z = newPos.y

func CheckForGround() -> bool:
	var below: String = get_parent().ReadTile(tilePosition, heightLayer - 1)
	return below != "Air" and below != "Goal"

func DropHeightLayer() -> int:
	var distance: int = 0
	position.y = heightLayer - 1
	while(heightLayer <= 0 && !CheckForGround()):
		heightLayer -= 1
		distance += 1
		get_parent().MoveTileScene(self, tilePosition, heightLayer)
		position.y = heightLayer - 1
	return distance

func Break():
	$Visuals.visible = false
	PlayBreakSound()
	get_parent().RemoveTileScene(self)

func PlayBreakSound():
	$BreakSound.stream = breakSounds.pick_random()
	$BreakSound.play()
