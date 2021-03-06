extends KinematicBody2D

const max_speed = 50
const acceleration = 500
const friction = 400

var velocity = Vector2.ZERO
var input_vector = Vector2.ZERO

var animation_player = null
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func _ready():
	animation_player = $AnimationPlayer

func _physics_process(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_state.travel("Run")
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed)
		print(velocity)
	else:
		animation_state.travel("Idle")
		
		velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	
	velocity = move_and_slide(velocity)
