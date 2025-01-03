class_name Enemy extends CharacterBody2D

@export var hp: float = 300

signal DirectionChanged(direction: Vector2)
signal EnemyDamaged(hurt_box: HurtBox)
signal EnemyDestroyed(hurt_box: HurtBox)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
# 获取对玩家的引用
var player: Player
# 是否无敌
var invulnerable: bool = false

@onready var enemy_sprite = $Sprite2D
@onready var enemy_animation: AnimationPlayer = $AnimationPlayer
@onready var hit_box: HitBox = $HitBox
@onready var state_machine: EnemyStateMachine = $StateMachine


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	player = PlayerManager.player
	hit_box.Damaged.connect(take_damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()

func updateAnimationDirection(_new_direction: Vector2):
	if _new_direction == null: 
		return
	
	direction = _new_direction
	
	if direction == Vector2.ZERO:
		return
	
	var dir_id: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[dir_id] 

	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	DirectionChanged.emit(cardinal_direction)
	return true

func getAnimationDirection():
	if cardinal_direction == Vector2.DOWN:
		return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	return "side"

func animateEnemy(enemy_state: String):
	var animate_name = enemy_state + "_" + getAnimationDirection()
	# 用scale可以允许子节点跟随一起翻转，而flip_h 只能当前节点自己翻转
	enemy_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	enemy_animation.play(animate_name)

func take_damage(hurt_box: HurtBox):
	if invulnerable == true:
		return

	hp -= hurt_box.damage
	if hp > 0:
		EnemyDamaged.emit(hurt_box)
	
	if hp <= 0:
		EnemyDestroyed.emit(hurt_box)
	