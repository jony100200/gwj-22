extends "res://scripts/CharTemplate.gd"



var motion= Vector2()
onready var skeleton = $Robot


func _physics_process(delta):
	update_movement()
	move_and_slide(motion)
	

func update_movement():
	if Input.is_action_pressed("move_right"):
		motion.x = SPEED
		skeleton.set("playback/curr_animation", "walk")
		skeleton.play(true)
	if Input.is_action_just_pressed("move_left"):
		motion.x -= SPEED
		#flipX(true)
		skeleton.set("playback/curr_animation", "walk")
		skeleton.play(true)
	else:
		motion.x=0
		skeleton.set("playback/curr_animation", "steady")
		skeleton.play(true)
