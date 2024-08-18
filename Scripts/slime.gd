extends Node3D
class_name Slime

@export var heightLayer: int = 1
@export var tilePosition: Vector2i = Vector2i.ZERO
var isDead: bool = false

@export var inControl: bool = false
var inGoal: bool = false
var isBig: bool

func ChangeTiles(newPos: Vector2i):
	tilePosition = newPos
	get_parent().MoveTileScene(self, tilePosition, heightLayer)
	$Visuals/SlimeBody/SlimeAnim.play("Green_Move1")
	position.x = newPos.x
	position.z = newPos.y
