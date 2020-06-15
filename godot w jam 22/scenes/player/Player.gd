extends KinematicBody2D

class_name Player

enum states {WALK, RUN, ATTACK, IDLE}

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
var state = states.IDLE
var previousState

var onGround = false
var hurt = false
var jump = false

signal died

func _ready() -> void:
	PlayerStats.connect("hpZero", self, "die")

func _physics_process(_delta):
	velocity.y += gravity
	stateLogic(_delta)
	velocity = move_and_slide(velocity,Vector2.UP,false,4,0.79,false)
	checkGround()
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

func handleInput():
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

func jump():
	if jumpCount < 2:
		jumpCount += 1
		velocity.y = -jumpSpeed
		onGround = false

func stateLogic(delta):
	handleInput()
	match state:
		states.IDLE:
			if direction != 0:
				changeState(states.WALK)
			if Input.is_action_just_pressed("ui_up"):
				jump()

		states.WALK:
			velocity.x = direction * MoveSpeed
			if Input.is_action_just_pressed("ui_up"):
				jump()
			if velocity.x == 0:
				changeState(states.IDLE)

func changeState(newState):
	exitState(newState, state)
	previousState = state
	state = newState
	enterState(state,previousState)

func enterState(oldState, newState):
	pass

func exitState(newState, oldState):
	pass
