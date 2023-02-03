extends Node

const MoveNames = preload("res://scripts/engine/MoveNames.gd")
const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")
const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")
var classHandler = ClassHandler.new()
var moveHandler = MoveHandler.new()
var moveNames = MoveNames.new()

onready var controlStep1 = $Control/ControlsStep1
onready var messageLabel = $Control/ControlsStep1/ScrollContainer/MessageLabel
onready var nextBtn = $Control/ControlsStep1/NextBtn

onready var controlStep2 = $Control/ControlsStep2
onready var fightBtn = $Control/ControlsStep2/FightBtn
onready var itemsBtn = $Control/ControlsStep2/ItemsBtn
onready var surrenderBtn = $Control/ControlsStep2/SurrenderBtn
var msgToShow = []

onready var controlStep3 = $Control/ControlsStep3
onready var move1Btn = $Control/ControlsStep3/Move1Btn
onready var move1Label = $Control/ControlsStep3/Move1Btn/Label
onready var move2Btn = $Control/ControlsStep3/Move2Btn
onready var move2Label = $Control/ControlsStep3/Move2Btn/Label
onready var move3Btn = $Control/ControlsStep3/Move3Btn
onready var move3Label = $Control/ControlsStep3/Move3Btn/Label
onready var move4Btn = $Control/ControlsStep3/Move4Btn
onready var move4Label = $Control/ControlsStep3/Move4Btn/Label

onready var controlStep4 = $Control/ControlsStep4
onready var messageLabe4 = $Control/ControlsStep4/ScrollContainer/MessageLabel

onready var unabiable = $Unaviable

var hero

var players = []

signal UseMove(move)
signal Surrender
signal showNextPlay

var loadingResults = true

func _ready():
	showControlStep1()
	
func showControlStep1():
	controlStep1.show()
	controlStep2.hide()
	controlStep3.hide()
	controlStep4.hide()

func showControlStep2():
	controlStep1.hide()
	controlStep2.show()
	controlStep3.hide()
	controlStep4.hide()

func showControlStep3():
	controlStep1.hide()
	controlStep2.hide()
	controlStep3.show()
	controlStep4.hide()

func showControlStep4():
	controlStep1.hide()
	controlStep2.hide()
	controlStep3.hide()
	controlStep4.show()
	var stats = Persistence.data.hero.stats
	for i in range(stats.size()):
		messageLabe4.bbcode_text += stats[i].name + " : " + str(stats[i].value) + "\n"
	

func setUnaviable(value: bool):
	unabiable.visible = value

func setHero(hero):
	self.hero = hero
	_setMoves()

func addEnemyPlayer(p):
	players.push_back(p)

func _setMoves():
	move1Btn.show()
	move2Btn.show()
	
	move1Label.text = moveNames.getMoveName(hero.charClass.name, hero.moves[0].id)
	move2Label.text = moveNames.getMoveName(hero.charClass.name, hero.moves[1].id)
	
	if hero.moves.size() >= 3:
		move3Label.text = moveNames.getMoveName(hero.charClass.name, hero.moves[2].id)
		move3Btn.show()
	
	if hero.moves.size() >= 4:
		move4Label.text = moveNames.getMoveName(hero.charClass.name, hero.moves[3].id)
		move4Btn.show()

func _process(delta):
	nextBtn.disabled = loadingResults


#################################################
# Control Step 1 Area
#################################################
func addMsg(newMsg):
	msgToShow.push_back(newMsg)

func showNewMsg():
	if msgToShow.size() <= 0:
		showControlStep2()
		return
	
	var msg = msgToShow[0]
	messageLabel.bbcode_text = msg
	
	msgToShow.remove(0)

func _on_NextBtn_pressed():
	showNewMsg()
	emit_signal("showNextPlay")

func _on_CombatScene_ShowMsg(playMsg):
	addMsg(playMsg[0])
	showControlStep1()
	showNewMsg()


func _on_CombatScene_IsLoading(state):
	loadingResults = state[0]


#################################################
# Control Step 2 Area
#################################################
func _on_FightBtn_pressed():
	showControlStep3()


func _on_SurrenderBtn_pressed():
	emit_signal("Surrender")



#################################################
# Control Step 3 Area
#################################################

func _on_Move1Btn_pressed():
	createMove(hero.moves[0])


func _on_Move2Btn_pressed():
	createMove(hero.moves[1])


func _on_Move3Btn_pressed():
	createMove(hero.moves[2])


func _on_Move4Btn_pressed():
	createMove(hero.moves[3])

func createMove(move):
	if move.type == moveHandler.ATTACK_MOVE:
		if players.size() == 1:
			emit_signal("UseMove", [move, players[0].position])
	else:
		emit_signal("UseMove", [move, hero.position])

func _on_BackFrom3Btn_pressed():
	showControlStep2()


func _on_BackFrom4Btn_pressed():
	showControlStep2()


func _on_StatsBtn_pressed():
	showControlStep4()
	
