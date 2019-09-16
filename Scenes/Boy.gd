extends KinematicBody2D

const GRAVITY = global_var.GRAVITY
const SPEED = 40
const FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = SPEED * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else: 
		$AnimatedSprite.flip_h = true

	$AnimatedSprite.play("Walking")
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall(): 
		direction *= -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction *= -1
		$RayCast2D.position.x *= -1