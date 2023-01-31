extends Node2D


var hero = {}
var verticalPosition
var horizontalPosition
var turnFor

const LEFT = "left"
const RIGHT = "right"

var isReady = false
var isAlive = true

onready var character = $KinematicBody2D
onready var nameLabel = $Status/NameLabel
onready var levelLabel = $Status/LevelLabel
onready var lifeBar = $Status/LifeBar
onready var statusLabel = $KinematicBody2D/StatusLabel
onready var points = $Status/Points

func setData(data, standX, standY, turnFor = RIGHT):
	hero = data
	horizontalPosition = standX
	verticalPosition = standY
	self.turnFor = turnFor

func setReady():
	isReady = true

func setThinking():
	isReady = false

func _ready():
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
	points.start("-" + str(damage), Color(1,0,0,0))

func sendHit():
	pass

func increaseStat(p):
	points.start("+" + str(points), Color(0,0,1,0))

func decreaseStat(p):
	points.start("-" + str(p), Color(1,0,1,0))

func increaseLife(life):
	points.start("+" + str(life), Color(0,1,0,0))

func miss():
	points.start("MISS", Color(1,1,1,0))




