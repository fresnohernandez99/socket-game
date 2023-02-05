extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 1.5
var velocity = Vector2()

const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")

var classHandler = ClassHandler.new()

var canMove = true

var isPlaying = false

var actualSprite
onready var sprites = [
	$Sprite_Class_1_H,
	$Sprite_Class_2_O,
	$Sprite_Class_3_G,
	$Sprite_Class_4_V,
	$Sprite_Class_5_S
]

onready var stepsAudio = $AudioStreamPlayer2D

func _ready():
	actualSprite = sprites[classHandler.getSpritePosByClass(Persistence.data.hero)]

	for s in sprites:
		if s != actualSprite:
			s.hide()
	

func get_input():
	velocity = Vector2()
	
	if canMove:
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
		actualSprite.animation = "idle"
		isPlaying = false
		stepsAudio.stop()
	else:
		actualSprite.animation = "move"
		if !isPlaying:
			isPlaying = true
			stepsAudio.play()
	
	if velocity.x != 0 :
		actualSprite.flip_h = velocity.x < 0
			
		
		 
