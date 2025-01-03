extends Node

var currentMapBounds: Array[Vector2] = []
signal MapBoundsChanged(bounds:  Array[Vector2])

func changeMapBounds(bounds: Array[Vector2]):
	currentMapBounds = bounds
	MapBoundsChanged.emit(bounds)
