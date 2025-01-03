extends State

@onready var move: State = $"../Move"
@onready var attack: State = $"../Attack"

func Enter():
  player.animatePlayer("stay")

func Process(delta: float):
  if player.direction != Vector2.ZERO:
    return move
  player.velocity = Vector2.ZERO 

func Physics(delta: float):
  pass

func HandleInput(event: InputEvent):
  if event.is_action_pressed("attack"):
    return attack
  return null
