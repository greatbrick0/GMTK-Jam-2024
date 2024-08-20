extends Node3D
class_name Slime

enum slimeTypes {
	Large = 0,
	Basic = 1,
	Slippy = 2,
	Angry = 3,
	Jumpy = 4,
	Brainy = 5
}

@export var init: bool = false
@export var slimeName: slimeTypes = slimeTypes.Basic
@export var heightLayer: int = 1
@export var tilePosition: Vector2i = Vector2i.ZERO
var isDead: bool = false

@export var inControl: bool = false
var inGoal: bool = false
var isBig: bool

const slimeComboMap: Dictionary = {
	[1, 1]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[1, 2]: "res://Scenes/Slimes/Big/large_slippy_slime.tscn",
	[1, 3]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[1, 4]: "res://Scenes/Slimes/Big/large_jumpy_slime.tscn",
	[1, 5]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[2, 2]: "res://Scenes/Slimes/Big/large_slippy_slime.tscn",
	[2, 3]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[2, 4]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[2, 5]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[3, 3]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[3, 4]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[3, 5]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[4, 4]: "res://Scenes/Slimes/Big/large_jumpy_slime.tscn",
	[4, 5]: "res://Scenes/Slimes/Big/large_basic_slime.tscn",
	[5, 5]: "res://Scenes/Slimes/Big/large_basic_slime.tscn", 
	}
const puzzleActionList: Array[String] = [
	"MoveUp",
	"MoveDown",
	"MoveLeft",
	"MoveRight",
	"Split"
	]

func ChangeTiles(newPos: Vector2i):
	tilePosition = newPos
	get_parent().MoveTileScene(self, tilePosition, heightLayer)
	position.x = newPos.x
	position.z = newPos.y

func GetTileScene(pos: Vector2i, y: int) -> Node3D:
	return get_parent().ReferenceByPosition(tilePosition + pos, heightLayer + y)
