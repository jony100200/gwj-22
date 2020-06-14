extends Area2D

class_name Hitbox

func enable():
	$CollisionShape2D.set_deferred("disabled", false)

func disable():
	$CollisionShape2D.set_deferred("disabled", true)
