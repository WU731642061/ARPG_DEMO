extends EnemyState

@export var animation_name: String = 'stay'

@export_category("AI")
@export var state_during_min: float = 0.5
@export var state_during_max: float = 1.5
@export var next_state: EnemyState

var _timer: float = 0.0

func Init():
  pass

func Enter():
  enemy.velocity = Vector2.ZERO
  _timer = randf_range(state_during_min, state_during_max)
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
