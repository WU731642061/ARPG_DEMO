extends Node

@onready var hitBox: HitBox = $HitBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitBox.Damaged.connect(takeDamage)


func takeDamage(_hurt_box: HurtBox):
	queue_free()