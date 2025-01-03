class_name HitBox extends Area2D

signal Damaged(hurt_box: HurtBox)


func _ready():
  # hit box 是代表承受伤害的一个容器，因此不需要检测别人，只需允许被别人检测
  monitoring = false;
  monitorable = true;

# 承受伤害
func takeDamage(hurt_box: HurtBox):
  Damaged.emit(hurt_box)
