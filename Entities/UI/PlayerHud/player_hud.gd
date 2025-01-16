extends CanvasLayer

var heart: Array[HeartGUI] = []

func _ready() -> void:
  var flowContainer = $Control/HFlowContainer 
  for child in flowContainer.get_children():
    if child is HeartGUI:
      heart.append(child)
      child.visible = false

func updateHp(_hp: int, _max_hp: int) -> void:
  updateMaxHp(_max_hp)
  for i in _max_hp:
    updateHeart(i, _hp)

func updateHeart(_index: int, _hp: int):
  var _value = clampi( _hp - _index * 2, 0, 2)
  heart[_index].value = _value
  pass

func updateMaxHp(_maxHp: int):
  var _heart_count = roundi(_maxHp * 0.5)
  for i in heart.size():
    if i < _heart_count:
      heart[i].visible = true
    else:
     heart[i].visible = false
  pass