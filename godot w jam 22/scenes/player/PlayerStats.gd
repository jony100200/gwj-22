extends Node

var hp = 4 setget setHp
export var maxHp = 4

signal hpZero

func _ready() -> void:
	hp = maxHp

func setHp(value):
	hp = value
	if hp <= 0:
		emit_signal("hpZero")
