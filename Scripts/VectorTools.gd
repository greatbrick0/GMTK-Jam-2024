extends Node

static var directionVectors: Array[Vector2i] = [
	Vector2i.UP, 
	Vector2i.UP + Vector2i.LEFT,
	Vector2i.LEFT,
	-Vector2i.UP + Vector2i.LEFT,
	-Vector2i.UP,
	-Vector2i.UP - Vector2i.LEFT,
	-Vector2i.LEFT,
	Vector2i.UP - Vector2i.LEFT
	]

static func VectorToString(dir: Vector2i) -> String:
	match dir:
		Vector2i.UP:
			return "Up"
		Vector2i.DOWN:
			return "Down"
		Vector2i.LEFT:
			return "Left"
		Vector2i.RIGHT:
			return "Right"
		_:
			return ""

static func Vec2ToVec3(vec2: Vector2) -> Vector3:
	return Vector3(vec2.x, 0, vec2.y)

static func Perpendicular(dir: Vector2) -> Vector2:
	var output: Vector2 = Vector2.ZERO
	output.x = -dir.y
	output.y = dir.x
	return output
