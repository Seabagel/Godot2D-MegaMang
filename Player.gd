extends KinematicBody2D

var velocity = Vector2(0, 0)
const SPEED = 200
const JUMP = 400
const GRAVITY = 30

func _physics_process(delta):
	move_horizontal()
	move_jump()
	animate()
	velocity = move_and_slide(velocity, Vector2.UP)

func move_horizontal():
	velocity.y = velocity.y + GRAVITY
	velocity.x = (-int(Input.is_key_pressed(KEY_A)) + int(Input.is_key_pressed(KEY_D))) * SPEED

func move_jump():
	if Input.is_action_just_pressed("action_jump"):
		velocity.y = -JUMP

func animate():
	# Flip left and right
	if Input.is_key_pressed(KEY_A):
		$AnimatedSprite.flip_h = true
	elif Input.is_key_pressed(KEY_D):
		$AnimatedSprite.flip_h = false
	
	# Detects movement and jumping
	if is_on_floor() and velocity.x == 0:
		$AnimatedSprite.play("idle")
	elif is_on_floor() and velocity.x != 0:
		$AnimatedSprite.play("running")
	else:
		$AnimatedSprite.play("jumping")
	
	
