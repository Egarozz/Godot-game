extends KinematicBody2D

const max_speed = 50
const acceleration = 500
const friction = 400

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO
func _ready():
	
	pass # Replace with function body.

func _physics_process(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed)
		print(velocity)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	
	velocity = move_and_slide(velocity)
