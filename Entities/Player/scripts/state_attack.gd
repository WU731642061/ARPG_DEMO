extends State

var attacking: bool = false 

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

@onready var stay: State = $"../Stay"
@onready var move: State = $"../Move"
@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_sprite: Sprite2D = $"../../Sprite2D/AttackEffectSprite2D"
@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite2D/AttackEffectAnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = %AttackHurtBox

func _ready() -> void:
  attack_sprite.visible  = false

func Enter():
  player.animatePlayer("attack")
  audio.stream = attack_sound
  audio.pitch_scale = randf_range(0.9, 1.1)
  audio.play()
  attacking = true;

  # 必须先await timeout再判定动画结束，这样状态才会正确转换，否则exit函数会优先执行
  await get_tree().create_timer(0.075).timeout
  hurt_box.monitoring = true

  await animation.animation_finished
  attacking = false;  


func Exit() -> void:
  hurt_box.monitoring = false

func Process(delta: float):
  player.velocity -= player.velocity * decelerate_speed * delta

  if not attacking:
    if player.direction == Vector2.ZERO:
      return stay
    else:
      return move

func Physics(delta: float):
  pass

func HandleInput(event: InputEvent):
  pass
