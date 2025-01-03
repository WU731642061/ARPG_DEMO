extends Node

@onready var map: TileMapLayer = $TileMapLayer

func _ready() -> void:
	MapManager.changeMapBounds(getMapBounds())

func getMapBounds():
	var bounds: Array[Vector2] = []

	bounds.append( Vector2(map.get_used_rect().position * map.rendering_quadrant_size))
	bounds.append( Vector2(map.get_used_rect().end * map.rendering_quadrant_size) )

	return bounds