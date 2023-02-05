extends KinematicBody2D

var jugador = null 
var move  = Vector2.ZERO
var vel = 130 

var IA
var hero 

var actualSprite
var velocity = Vector2()

const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")

var classHandler = ClassHandler.new()

export (int) var level = -1
export (String) var iaName = "" 
  
onready var sprites = [
	$Sprite_Class_1_H,
	$Sprite_Class_2_O,
	$Sprite_Class_3_G,
	$Sprite_Class_4_V,
	$Sprite_Class_5_S
]
onready var nameLabel = $NameLabel

const BaseIAEnemy = preload("res://scripts/engine/IA/BaseIAEnemy.gd")

signal start
 
func _ready():
	randomize()
	
	if iaName == "":
		SocketRooms.names.shuffle()
		iaName = SocketRooms.names.pop_back()
		SocketRooms.nextToUse.push_back(iaName)
	
	if level == -1:
		if Persistence.data.hero.level <= 2:
			level = int(rand_range(1, 3))
		else:
			level = int(rand_range(Persistence.data.hero.level - 1, Persistence.data.hero.level + 3))
	
	IA = BaseIAEnemy.new().getNewNpc(iaName, level)
	hero = IA.handDeck.items[0]
	
	nameLabel.text = iaName + " LV " + str(hero.level)
	
	actualSprite = sprites[classHandler.getSpritePosByClass(hero)]

	for s in sprites:
		if s != actualSprite:
			s.hide()

func _physics_process(delta):
	move = Vector2.ZERO
	
	if jugador != null:
		move = position.direction_to(jugador.position)
	  
	else: 
		move = Vector2.ZERO 
		
	move = move.normalized() * vel 
	move = move_and_slide(move)
	
	if move.y == 0 && move.x == 0:
		actualSprite.animation = "idle"
	else:
		actualSprite.animation = "move"
	
	if move.x != 0 :
		actualSprite.flip_h = move.x < 0

func _on_distance_body_entered(body):
	if body.is_in_group("player"):
		jugador = body

func _on_distance_body_exited(body):
	jugador = null

func _on_start_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("start")
		RoomInfo.actualIAHero = IA
