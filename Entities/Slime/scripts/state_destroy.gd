extends EnemyState

@export var animation_name: String = 'destroy'
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")
var _direction: Vector2
var _damaged_position: Vector2

func Init():
  enemy.EnemyDestroyed.connect(_on_enemy_destroyed)
  pass

func Enter():
  enemy.invulnerable = true

  _direction = enemy.global_position.direction_to(_damaged_position)
  enemy.updateAnimationDirection(_direction)
  enemy.velocity = _direction * -knockback_speed

  enemy.animateEnemy(animation_name)
  enemy.enemy_animation.animation_finished.connect(_on_animation_finished)

func Process(delta: float):
  enemy.velocity -= enemy.velocity * decelerate_speed * delta  
  pass

func _on_enemy_destroyed(_hurt_box: HurtBox):
  _damaged_position = _hurt_box.global_position
  enemyStateMachine.ChangeState(self)

func _on_animation_finished(s: String):
  enemy.queue_free()
