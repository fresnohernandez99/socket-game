extends Node


onready var resultLabel = $Control/ResultLabel

onready var pointsLabel1 = $Control/VBoxContainer/Stat1/StatPoint
onready var pointsLabel2 = $Control/VBoxContainer/Stat2/StatPoint
onready var pointsLabel3 = $Control/VBoxContainer/Stat3/StatPoint
onready var pointsLabel4 = $Control/VBoxContainer/Stat4/StatPoint
onready var pointsLabel5 = $Control/VBoxContainer/Stat5/StatPoint
onready var pointsLabel6 = $Control/VBoxContainer/Stat6/StatPoint

onready var pointBtn1 = $Control/VBoxContainer/Stat1/Button1
onready var pointBtn2 = $Control/VBoxContainer/Stat2/Button2
onready var pointBtn3 = $Control/VBoxContainer/Stat3/Button3
onready var pointBtn4 = $Control/VBoxContainer/Stat4/Button4
onready var pointBtn5 = $Control/VBoxContainer/Stat5/Button5
onready var pointBtn6 = $Control/VBoxContainer/Stat6/Button6

onready var attacks = $Control/Attacks
onready var attacksLabel = $Control/Attacks/Label
onready var pos1 = $Control/Attacks/Move1Btn/Label
onready var pos2 = $Control/Attacks/Move2Btn/Label
onready var pos3 = $Control/Attacks/Move3Btn/Label
onready var pos4 = $Control/Attacks/Move4Btn/Label


const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")
const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")
const MoveNames = preload("res://scripts/engine/MoveNames.gd")
var classHandler = ClassHandler.new()
var moveHandler = MoveHandler.new()
var moveNames = MoveNames.new()


var stats 
var uLose = false
var heroAgainst

var talentPoints = 0

var newAttacksEarned = []
var actualToLearn = null

func _ready():
	stats = Persistence.data.hero.stats 
	for p in RoomInfo.finalResult:
		if p.lifePointsLose > p.lifePoints:
			if p.id == Persistence.data.hero.id:
				uLose = true
		if p.id != Persistence.data.hero.id:
			heroAgainst = p

	var experience

	if !uLose:
		experience = calculateExperienceEarnedIfWin()
	else:
		experience = calculateExperienceEarnedIfLose()
	
	calculateTalentPoints(experience)

	if newAttacksEarned.size() > 0:
		showUpdateAttakcs()

	updateUi()

func calculateTalentPoints(experience):
	if Persistence.data.hero.nextLevelOnEarned + experience >= Persistence.data.hero.nextLevelOn:
		var extra = Persistence.data.hero.nextLevelOnEarned + experience - Persistence.data.hero.nextLevelOn
		
		Persistence.data.hero.nextLevelOnEarned = extra
		
		Persistence.data.hero.nextLevelOn += Persistence.data.hero.nextLevelOn * 0.3
		
		talentPoints += 1
		
		Persistence.data.hero.level += 1
		
		calculateTalentPoints(extra)
		
		var newMove = getNewPower()
		if newMove != null:
			newAttacksEarned.push_front(newMove)
		
		Persistence.save_data()

func getNewPower():
	var level = Persistence.data.hero.level
	var newMove = moveHandler.generateNextMove(classHandler, Persistence.data.hero)
	return newMove

func showUpdateAttakcs():
	actualToLearn = newAttacksEarned.pop_back()
	
	attacks.show()
	var hero = Persistence.data.hero
	
	attacksLabel.text = "Aprender: " + moveNames.getMoveName(hero.charClass.name, actualToLearn.id)
	
	pos1.text = moveNames.getMoveName(hero.charClass.name, hero.moves[0].id)
	pos1.text = moveNames.getMoveName(hero.charClass.name, hero.moves[1].id)
	
	if hero.moves.size() >= 3:
		pos1.text = moveNames.getMoveName(hero.charClass.name, hero.moves[2].id)
	
	if hero.moves.size() >= 4:
		pos1.text = moveNames.getMoveName(hero.charClass.name, hero.moves[3].id)


func calculateExperienceEarnedIfWin():
	if heroAgainst.level > Persistence.data.hero.level:
		var lvDiference = heroAgainst.level - Persistence.data.hero.level
		
		return lvDiference * 20
	else:
		var lvDiference = Persistence.data.hero.level - heroAgainst.level
		
		return lvDiference * 10

func calculateExperienceEarnedIfLose():
	if heroAgainst.level > Persistence.data.hero.level:
		var lvDiference = heroAgainst.level - Persistence.data.hero.level
		
		return lvDiference * 10
	else:
		var lvDiference = Persistence.data.hero.level - heroAgainst.level
		
		return lvDiference * 5

func updateUi():
	pointsLabel1.text = str(stats[0].value)
	pointsLabel2.text = str(stats[1].value)
	pointsLabel3.text = str(stats[2].value)
	pointsLabel4.text = str(stats[3].value)
	pointsLabel5.text = str(stats[4].value)
	pointsLabel6.text = str(stats[5].value)
	if talentPoints == 0:
		pointBtn1.disabled = true 
		pointBtn2.disabled = true 
		pointBtn3.disabled = true 
		pointBtn4.disabled = true 
		pointBtn5.disabled = true 
		pointBtn6.disabled = true 

		
func _on_Button1_pressed():
	if talentPoints != 0:
		talentPoints = talentPoints-1
		stats[0].value = stats[0].value+1
		updateUi()


func _on_Button2_pressed():
	if talentPoints != 0:
		talentPoints = talentPoints-1
		stats[1].value = stats[1].value+1
		updateUi()


func _on_Button3_pressed():
	if talentPoints != 0:
		talentPoints = talentPoints-1
		stats[2].value = stats[2].value+1
		updateUi()


func _on_Button4_pressed():
	if talentPoints != 0:
		talentPoints = talentPoints-1
		stats[3].value = stats[3].value+1
		updateUi()


func _on_Button5_pressed():
	if talentPoints != 0:
		talentPoints = talentPoints-1
		stats[4].value = stats[4].value+1
		updateUi()


func _on_Button6_pressed():
	if talentPoints != 0:
		talentPoints = talentPoints-1
		stats[5].value = stats[5].value+1
		updateUi()


func _on_ExitBtn_pressed():
	Persistence.save_data()
	get_tree().change_scene("res://scenes/gui/RoomList.tscn")


func _on_Move1Btn_pressed():
	Persistence.data.hero.moves[0] = actualToLearn
	Persistence.save_data()
	toastHasLearn()
	if newAttacksEarned.size() > 0:
		showUpdateAttakcs()


func _on_Move2Btn_pressed():
	Persistence.data.hero.moves[1] = actualToLearn
	Persistence.save_data()
	toastHasLearn()
	if newAttacksEarned.size() > 0:
		showUpdateAttakcs()


func _on_Move3Btn_pressed():
	Persistence.data.hero.moves[2] = actualToLearn
	Persistence.save_data()
	if newAttacksEarned.size() > 0:
		showUpdateAttakcs()


func _on_Move4Btn_pressed():
	Persistence.data.hero.moves[3] = actualToLearn
	Persistence.save_data()
	toastHasLearn()
	if newAttacksEarned.size() > 0:
		showUpdateAttakcs()

func toastHasLearn():
	var toast = Toast.new("Has aprendido: " + moveNames.getMoveName(Persistence.data.hero.charClass.name, actualToLearn.id), Toast.LENGTH_SHORT)
	get_node("/root").add_child(toast)
	toast.show()
