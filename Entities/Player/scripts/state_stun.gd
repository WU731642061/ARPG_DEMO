extends State

@onready var stay: State = $"../Stay"
@onready var move: State = $"../Move"
@onready var attack: State = $"../Attack"

@export var animation_name: String = 'stun'
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box: HurtBox
var direction: Vector2

var next_state: State = null

func Init():
	player.PlayerDamaged.connect(playerDamaged)

func Enter():
	player.player_animation.animation_finished.connect(animationFinished)

	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * -knockback_speed
	player.updateAnimationDirection()
	player.animatePlayer(animation_name)

	player.make_invulnerable(invulnerable_duration)
	player.effect_player.play('damaged')

func Exit():
	next_state = null
	player.player_animation.animation_finished.disconnect(animationFinished)

func Process(delta: float):
	player.velocity -= player.velocity * decelerate_speed * delta
	return next_state

func Physics(delta: float):
	pass

func HandleInput(event: InputEvent):
	return null

func playerDamaged(_hurt_box: HurtBox) -> void:
	hurt_box = _hurt_box
	state_machine.ChangeState(self)

func animationFinished(_a: String):
	next_state = stay