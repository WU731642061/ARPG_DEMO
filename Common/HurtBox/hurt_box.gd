class_name HurtBox extends Area2D

@export var damage: int = 1

func _ready():
	area_entered.connect(areaEnter)

func areaEnter(target: Area2D ):
	if target is HitBox:
		target.takeDamage(self)
