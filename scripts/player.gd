extends CharacterBody2D

const SPEED = 100.0
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	var dx = 0
	var dy = 0
	
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		current_dir = "down"
		dy += SPEED
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		current_dir = "up"
		dy -= SPEED
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		current_dir = "right"
		dx += SPEED
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		current_dir = "left"
		dx -= SPEED
	
	velocity.x = dx
	velocity.y = dy
	
	play_anim(dx, dy)
	
	move_and_slide()

func play_anim(dx: int, dy: int):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	var idle: bool = dx == 0 and dy == 0
	
	if dir == "left":
		anim.flip_h = true
	else:
		anim.flip_h = false
	
	if dir == "right" or dir == "left":
		if idle:
			anim.play("side_idle")
		else:
			anim.play("side_walk")
	elif dir == "down":
		if idle:
			anim.play("front_idle")
		else:
			anim.play("front_walk")
	elif dir == "up":
		if idle:
			anim.play("back_idle")
		else:
			anim.play("back_walk")

