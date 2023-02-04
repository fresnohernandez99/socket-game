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
onready var pointBtn6 = $Control/VBoxContainer/Stat6/Button6\

	
var stats 
var uLose = false
var heroAgainst

var talentPoints = 5

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

	updateUi()

func calculateTalentPoints(experience):
	if Persistence.data.hero.nextLevelOnEarned + experience >= Persistence.data.hero.nextLevelOn:
		var extra = Persistence.data.hero.nextLevelOnEarned + experience - Persistence.data.hero.nextLevelOn
		
		Persistence.data.hero.nextLevelOnEarned = extra
		
		Persistence.data.hero.nextLevelOn += Persistence.data.hero.nextLevelOn * 0.3
		
		talentPoints += 1
		
		calculateTalentPoints(extra)
		
		Persistence.save_data()

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
	pass # Replace with function body.
