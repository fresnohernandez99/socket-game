extends Node2D


var hero = {}
var verticalPosition
var horizontalPosition
var turnFor

const LEFT = "left"
const RIGHT = "right"

var isReady = false
var isAlive = true

const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")

var classHandler = ClassHandler.new()

onready var character = $KinematicBody2D
onready var nameLabel = $Status/NameLabel
onready var levelLabel = $Status/LevelLabel
onready var lifeBar = $Status/LifeBar
onready var statusLabel = $KinematicBody2D/StatusLabel
onready var points = $Status/Points
onready var typebackground = $Status/TypeBackground

onready var tween = $Tween
onready var wTween = $WeaponTween

onready var weapon = $KinematicBody2D/Weapon
onready var idol = $KinematicBody2D/Idol

var actualTweenInterpolation

var actualSprite
onready var sprites = [
	$KinematicBody2D/Sprite_Class_1_H,
	$KinematicBody2D/Sprite_Class_2_O,
	$KinematicBody2D/Sprite_Class_3_G,
	$KinematicBody2D/Sprite_Class_4_V,
	$KinematicBody2D/Sprite_Class_5_S
]

onready var audio = $AudioStreamPlayer2D

onready var hitSounds = [
	load("res://assets/sfx/hit_1.wav"),
	load("res://assets/sfx/hit_2.wav"),
	load("res://assets/sfx/hit_3.wav"),
	load("res://assets/sfx/hit_4.wav")
]

onready var powerSounds = [
	load("res://assets/sfx/attack_1.wav"),
	load("res://assets/sfx/attack_2.wav"),
	load("res://assets/sfx/attack_3.wav"),
	load("res://assets/sfx/attack_4.wav"),
]

onready var idols = [
	load("res://assets/imgs/heroe/hercules.svg"),
	load("res://assets/imgs/heroe/oshosi.svg"),
	load("res://assets/imgs/heroe/templar.svg"),
	load("res://assets/imgs/heroe/dios_veles.svg"),
	load("res://assets/imgs/heroe/susanoo_dios.svg")
]

func setData(data, standX, standY, turnFor = RIGHT):
	hero = data
	horizontalPosition = standX
	verticalPosition = standY
	self.turnFor = turnFor

func setReady():
	isReady = true

func setThinking():
	isReady = false

func setAnim(anim):
	actualSprite.animation = anim
	actualSprite.frame = 0

func _ready():
	randomize()
	typebackground.color = classHandler.getColorByClass(hero)
	
	actualSprite = sprites[classHandler.getSpritePosByClass(hero)]
	weapon.animation = classHandler.getWeaponByClass(hero)
	
	idol.texture = idols[classHandler.getSpritePosByClass(hero)]
	
	if hero.id != Persistence.data.hero.id:
		modulate = Color(0.8, 0.8, 0.8, 1)
	
	for s in sprites:
		if s != actualSprite:
			s.hide()
	
	global_position.x = horizontalPosition
	
	if turnFor == LEFT:
		character.scale.x = -1
	
	nameLabel.text = hero.name
	levelLabel.text = "LV: " + str(hero.level)
	lifeBar.max_value = hero.lifePoints
	lifeBar.value = hero.lifePoints

func _process(delta):
	if isAlive:
		if verticalPosition > global_position.y:
			global_position.y += 8
	else:
		if -100 < global_position.y:
			global_position.y -= 8
	
	lifeBar.value = hero.lifePoints - hero.lifePointsLose
	
	if isReady:
		statusLabel.show()
	else:
		statusLabel.hide()

func lose():
	isAlive = false

func receiveHit(damage):
	actualTweenInterpolation = [Color(1,1,1,1), Color(1,0.5,0.5,1)]
	
	points.start("-" + str(damage), Color(1,0,0,0))
	
	startTween()
	yieldAndReset()
	
	audio.stream = hitSounds[int(rand_range(0, hitSounds.size()))]
	audio.play()

func sendHit():
	audio.stream = powerSounds[int(rand_range(0, hitSounds.size()))]
	audio.play()
	
	if hero.id == Persistence.data.hero.id:
		wTween.interpolate_property(weapon, "global_position", Vector2(weapon.global_position.x, weapon.global_position.y), Vector2(weapon.global_position.x + 200, weapon.global_position.y), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
		wTween.start()
		
		yield(get_tree().create_timer(1.2), "timeout")
		
		wTween.interpolate_property(weapon, "global_position", Vector2(weapon.global_position.x, weapon.global_position.y), Vector2(weapon.global_position.x - 200, weapon.global_position.y), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		wTween.start()
	else:
		wTween.interpolate_property(weapon, "global_position", Vector2(weapon.global_position.x, weapon.global_position.y), Vector2(weapon.global_position.x - 200, weapon.global_position.y), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
		wTween.start()
		
		yield(get_tree().create_timer(1.2), "timeout")
		
		wTween.interpolate_property(weapon, "global_position", Vector2(weapon.global_position.x, weapon.global_position.y), Vector2(weapon.global_position.x + 200, weapon.global_position.y), 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		wTween.start()

func increaseStat(p):
	actualTweenInterpolation = [Color(1,1,1,1), Color(0.5,0.5,1,1)]
	
	points.start("+" + str(p), Color(0,0,1,0))
	
	startTween()
	yieldAndReset()

func decreaseStat(p):
	points.start("-" + str(p), Color(1,0,1,0))

func increaseLife(life):
	actualTweenInterpolation = [Color(1,1,1,1), Color(0.5,1,0.5,1)]
	
	points.start("+" + str(life), Color(0,1,0,0))
	
	startTween()
	yieldAndReset()

func miss():
	points.start("MISS", Color(1,1,1,0))


func startTween():
	tween.interpolate_property(self, "modulate", actualTweenInterpolation[0], actualTweenInterpolation[1], 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func yieldAndReset():
	yield(get_tree().create_timer(1), "timeout")
	actualTweenInterpolation.invert()
	
	startTween()

