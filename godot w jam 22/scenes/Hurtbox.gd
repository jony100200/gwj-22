extends Area2D

class_name Hurtbox

func enable():
	$CollisionShape2D.set_deferred("disabled", false)

func disable():
	$CollisionShape2D.set_deferred("disabled", true)
