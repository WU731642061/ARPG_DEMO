class_name HeartGUI extends Control

@onready var sprite_2d: Sprite2D = $Sprite2D

# 0 | 1 | 2
var value: int = 2 :
  set( _value ):
    value = _value
    updateHeartGui() 

func updateHeartGui():
  sprite_2d.frame = value