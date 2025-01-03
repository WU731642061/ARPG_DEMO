class_name EnemyStateMachine extends Node

var states: Array[EnemyState]

var prev_state: EnemyState

var current_state: EnemyState


func _ready() -> void:
  process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
  ChangeState(current_state.Process(delta))

func _physics_process(delta: float) -> void:
  ChangeState(current_state.Physics(delta))

func _unhandled_input(event: InputEvent) -> void:
  ChangeState(current_state.HandleInput(event))

func Initialize(enemy: Enemy):
  states = []
  for c in get_children():
    print(c, c is EnemyState)
    if c is EnemyState:
      states.append(c)
  
  for s in states:
    s.enemy = enemy
    s.enemyStateMachine = self
    s.Init()

  if states.size() > 0:
    ChangeState(states[0])
    process_mode = Node.PROCESS_MODE_INHERIT   

func ChangeState(new_state: EnemyState):
  if  new_state == null || new_state == current_state:
    return
  
  if current_state:
    current_state.Exit()
  
  prev_state = current_state
  current_state = new_state
  current_state.Enter()
