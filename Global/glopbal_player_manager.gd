extends Node

const PLAYER = preload("res://Entities/Player/Player.tscn")

var player: Player
var playerSpawned: bool = false

func _ready() -> void:
  add_player_instance()
  # await get_tree().create_timer(0.5)
  # playerSpawned = true

func add_player_instance():
  player = PLAYER.instantiate()

func set_player_position(newPosition: Vector2):
  player.global_position = newPosition

func set_as_parent(p: Node2D):
  if player.get_parent():
    player.get_parent().remove_child(player)
  p.add_child(player)

func unparent_player(p: Node2D):
  p.remove_child(player)