extends KinematicBody2D

class_name Player

export var _dashSpeed = 350
export var gravity = 20
export var maxSpeed = 200
export var MoveSpeed = 500
export var jumpSpeed = 500

onready var hitbox : Area2D = $Hitbox
onready var hurtbox : Area2D = $Hurtbox
onready var sprite : Sprite = $player

var direction = 0
var velocity = Vector2.ZERO
var jumpCount = 0

var onGround = false
var hurt = false

signal died

func _ready() -> void:
	PlayerStats.connect("hpZero", self, "die")

func _physics_process(_delta):
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * MoveSpeed
	velocity.y += gravity
	if Input.is_action_just_pressed("ui_up"):
		if jumpCount < 1:
			jumpCount += 1
			velocity.y = -jumpSpeed
			onGround = false
	checkGround()
	if direction:
		hurtbox.position = Vector2(70 * direction, -30  )
	velocity = move_and_slide(velocity,Vector2.UP,false,4,0.79,false)
	animate()


func animate():
	if direction != 0:
		sprite.flip_h = direction > 0

func checkGround():
	if is_on_floor():
		if onGround == false:
			onGround = true
			jumpCount = 0
	else:
		if onGround == true:
			onGround = false

func die():
	yield(get_tree().create_timer(.5),"timeout")
	emit_signal("died")
	queue_free()
