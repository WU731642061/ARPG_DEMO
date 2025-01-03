extends State

@export var speed: float = 100.0;

@onready var stay: State = $"../Stay"
@onready var attack: State = $"../Attack"

func Enter():
  player.animatePlayer("move")

func Process(delta: float):
  if player.direction == Vector2.ZERO:
    return stay
  
  player.velocity = player.direction * speed
  if  player.updateAnimationDirection():
    player.animatePlayer('move')


func Physics(delta: float):
  pass

func HandleInput(event: InputEvent):
  if event.is_action_pressed("attack"):
    return attack
  return null
