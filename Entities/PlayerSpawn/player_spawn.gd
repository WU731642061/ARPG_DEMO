extends Node2D

func _ready() -> void:
  self.visible = false
  if PlayerManager.playerSpawned == false:
    PlayerManager.set_player_position(global_position)
    PlayerManager.playerSpawned = true

