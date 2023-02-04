extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 1.5
onready var animatedSprite = $Nino
var velocity = Vector2()

func _ready():
	pass
	

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _process(delta):
	get_input()
	velocity = move_and_slide(velocity)
		
	if velocity.y == 0 && velocity.x == 0:
		animatedSprite.animation = "idle"
	else:
		animatedSprite.animation = "move"
	
	if velocity.x != 0 :
		animatedSprite.flip_h = velocity.x < 0
			
		
		 
