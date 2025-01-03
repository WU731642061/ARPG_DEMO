class_name PlayerCamera extends Camera2D

func _ready() -> void:
  MapManager.MapBoundsChanged.connect(updateLimits)

func updateLimits(bounds: Array[Vector2]):
  limit_left = int(bounds[0].x)
  limit_top =  int(bounds[0].y)
  limit_right =  int(bounds[1].x)
  limit_bottom =  int(bounds[1].y)
