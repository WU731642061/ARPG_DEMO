extends Node2D

@onready var map: TileMapLayer = $TileMapLayer

func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent(self)
	MapManager.changeMapBounds(getMapBounds())

func getMapBounds():
	var bounds: Array[Vector2] = []

	bounds.append( Vector2(map.get_used_rect().position * map.rendering_quadrant_size) )
	bounds.append( Vector2(map.get_used_rect().end * map.rendering_quadrant_size) )

	return bounds