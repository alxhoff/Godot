extends KinematicBody2D

const GRAVITY = global_var.GRAVITY
const SPEED = 40
const FLOOR = Vector2(0, -1)

var alive = true

var velocity = Vector2()

var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func kill():
	alive = false
	$CollisionShape2D.call_deferred("set_disabled", true)
	$AnimatedSprite.play("Dying")
	$Timer.start()
	pass
	

func _physics_process(delta):
	
	if alive:
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

func _on_Timer_timeout():
	queue_free()
