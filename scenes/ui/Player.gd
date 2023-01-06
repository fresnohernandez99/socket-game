extends Node2D


var hero = {}
var verticalPosition
var horizontalPosition
var turnFor

const LEFT = "left"
const RIGHT = "right"

var isReady = false

onready var statusLabel = $Status/StatusLabel
onready var character = $KinematicBody2D

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
	#FOR TEST
	setData(null, 60, 200, LEFT)
	#
	
	global_position.x = horizontalPosition
	
	if turnFor == LEFT:
		character.scale.x = -1

func _process(delta):
	if verticalPosition > global_position.y:
		global_position.y += 8
	
	if isReady:
		statusLabel.text = "READY!"
	else:
		statusLabel.text = ""








