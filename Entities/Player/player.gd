extends CharacterBody2D

class_name Player

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var player_sprite = $Sprite2D
@onready var player_animation: AnimationPlayer = $AnimationPlayer
@onready var effect_player: AnimationPlayer = $EffectPlayer
@onready var attack_sprite = $"Sprite2D/AttackEffectSprite2D"
@onready var attack_animation: AnimationPlayer = $"Sprite2D/AttackEffectSprite2D/AttackEffectAnimationPlayer"
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox

signal DirectionChanged(new_direction: Vector2)
signal PlayerDamaged(hurt_box: HurtBox)

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

var invulnerable: bool = false
var hp: int = 6
var max_hp: int = 6

func _ready() -> void:
	PlayerManager.player = self
	state_machine.Initialize(self)
	hit_box.Damaged.connect(_take_damage)
	update_hp(max_hp)

func _process(delta: float):
	# direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	# direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	# # 归一化方向的模，防止获得大于1的加速度
	# direction.normalized()
	# 可读性更好的写法
	direction = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()

func _physics_process(delta: float) -> void:
	move_and_slide()

func updateAnimationDirection():
	if direction == Vector2.ZERO:
		return false
	
	var dir_id: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[dir_id]

	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	if direction.x == 0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == cardinal_direction:
		return false

	cardinal_direction = new_dir
	DirectionChanged.emit(new_dir)
	return true

func getAnimationDirection():
	if cardinal_direction == Vector2.DOWN:
		return "down"
	if cardinal_direction == Vector2.UP:
		return "up"
	return "side"

func animatePlayer(player_state: String):
	var animate_name = player_state + "_" + getAnimationDirection()
	# 用scale可以允许子节点跟随一起翻转，而flip_h 只能当前节点自己翻转
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	player_animation.play(animate_name)

	if player_state == 'attack':
		attack_animation.play(animate_name)

func _take_damage(hurt_box: HurtBox):
	if invulnerable == true:
		return

	update_hp( -hurt_box.damage)
	if hp > 0:
		PlayerDamaged.emit(hurt_box)
	else:
		PlayerDamaged.emit(hurt_box)
		update_hp(max_hp)


func update_hp(delta: int):
	hp = clampi(hp + delta, 0, max_hp )
	pass

func make_invulnerable(duration: float):
	invulnerable = true
	hit_box.monitoring = false

	await get_tree().create_timer(duration).timeout
	invulnerable = false
	hit_box.monitoring = true
	pass