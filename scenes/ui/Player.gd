extends Node2D


var hero = {}
var verticalPosition
var horizontalPosition
var turnFor

const LEFT = "left"
const RIGHT = "right"

var isReady = false

onready var statusLabel = $StatusLabel

func setData(data, standX, standY, turnFor = RIGHT):
	hero = data
	horizontalPosition = standX
	verticalPosition = standY
	self.turnFor = turnFor
	
	print(str(horizontalPosition), " ", str(verticalPosition))

func setReady():
	isReady = true

func setThinking():
	isReady = false

func _ready():
	global_position.x = horizontalPosition
	
	if turnFor == LEFT:
		scale.x = -1

func _process(delta):
	if verticalPosition < global_position.y:
		global_position.y += 0.1
		print(str(global_position.y))
	
	if isReady:
		statusLabel.text = "READY!"
	else:
		statusLabel.text = ""








