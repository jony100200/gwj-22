extends KinematicBody2D

enum states {WANDER, CHASE, ATTACK, IDLE}

export var _dashSpeed = 350
export var gravity = 20
export var maxSpeed = 200
export var MoveSpeed = 500
export var jumpSpeed = 500

onready var areaOfSight = $PlayerDetector
onready var sprite = $enemy

var direction = 0
var velocity = Vector2.ZERO
var jumpCount = 0
var state = states.WANDER
var previousState
var target
var wanderDir = -1
var wallRays

func _ready() -> void:
	wallRays = $WallDetector.get_children()

func _physics_process(delta: float) -> void:
	velocity.y += gravity
	stateLogic(delta)
	velocity = move_and_slide(velocity)

func stateLogic(delta):
	match state:
		states.WANDER:
			for r in wallRays:
				if r.is_colliding():
					wanderDir *= -1
			velocity.x = wanderDir * MoveSpeed
			sprite.flip_h = !wanderDir
		states.CHASE:
			if target != null:
				velocity.x = position.direction_to(target.position).x * MoveSpeed
				if position.distance_to(target.position) < 5:
					velocity.x = lerp(velocity.x, 0,delta)
					changeState(states.ATTACK)



func changeState(newState):
	exitState(newState, state)
	previousState = state
	state = newState
	enterState(state,previousState)

func enterState(oldState, newState):
	pass

func exitState(newState, oldState):
	pass

func _on_PlayerDetector_body_entered(body: Node) -> void:
	target = body
	changeState(states.CHASE)

func _on_PlayerDetector_body_exited(body: Node) -> void:
	target = null
	changeState(states.WANDER)

func _on_WanderTimer_timeout() -> void:
	wanderDir *= -1
