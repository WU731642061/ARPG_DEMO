extends EnemyState

@export var animation_name: String = 'move'
@export var wander_speed: float = 30.0

@export_category("AI")
@export var state_animation_during: float = 0.7
@export var state_cycle_min: int = 1
@export var state_cycle_max: int = 3
@export var next_state: EnemyState

var _timer: float = 0.0
var _direction: Vector2

func Init():
  pass

func Enter():
  _timer = randi_range(state_cycle_min, state_cycle_max) * state_animation_during
  var rand = randi_range(1,3)
  _direction = enemy.DIR_4[rand]
  enemy.velocity = _direction * wander_speed
  enemy.updateAnimationDirection(_direction)
  enemy.animateEnemy(animation_name)

func Exit():
  pass

func Process(delta: float):
  _timer -= delta
  if _timer <= 0:
    return next_state

func Physics(delta: float):
  pass

func HandleInput(event: InputEvent):
  pass
