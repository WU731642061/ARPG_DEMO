class_name State extends Node

static var player: Player
static var state_machine: PlayerStateMachine

func Init():
  pass

# 当玩家进入当前状态
func Enter():
  pass

# 当玩家退出当前状态
func Exit():
  pass

func Process(delta: float):
  pass

func Physics(delta: float):
  pass

func HandleInput(event: InputEvent):
  pass
