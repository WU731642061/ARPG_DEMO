extends EnemyState

@export var animation_name: String = 'stun'
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")
@export var next_state: EnemyState

var _direction: Vector2
var _animation_finished: bool = false
var _damaged_position: Vector2

func Init():
  enemy.EnemyDamaged.connect(_on_enemy_damaged)
  pass

func Enter():
  enemy.invulnerable = true
  _animation_finished = false
  _direction = enemy.global_position.direction_to(_damaged_position)
  print(_damaged_position, _direction)
  enemy.updateAnimationDirection(_direction)
  enemy.velocity = _direction * -knockback_speed

  enemy.animateEnemy(animation_name)
  enemy.enemy_animation.animation_finished.connect(_on_animation_finished)

func Exit():
  enemy.invulnerable = false
  enemy.enemy_animation.animation_finished.disconnect(_on_animation_finished)
  pass

func Process(delta: float):
  if _animation_finished == true:
    return next_state
  enemy.velocity -= enemy.velocity * decelerate_speed * delta  
  pass

func _on_enemy_damaged(_hurt_box: HurtBox):
  # 个人觉得这种方法会使得代码太绕，增加了代码的耦合性，这里主要是跟着视频学习的逻辑
  # 这里将position传给了_damaged_position, 然后调用了状态机的change state方法，然后状态机会调用当前实例的Enter方法
  # 所以只要确保这个关系,enter就能正确获取到位置, 但是坏处是很容易过段时间就忘记这块的业务逻辑
  # TODO: 后续看看优化这块的逻辑
  _damaged_position = _hurt_box.global_position
  enemyStateMachine.ChangeState(self)

func _on_animation_finished(_s: String):
  _animation_finished = true

  