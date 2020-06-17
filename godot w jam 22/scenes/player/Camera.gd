extends Camera2D

export var lock_y = 1080/2.0
func _physics_process(delta: float) -> void:
	global_position.y = lock_y
