extends Node


onready var resultLabel = $Control/ResultLabel

onready var pointsLabel1 = $Control/VBoxContainer/Stat1/StatPoint
onready var pointsLabel2 = $Control/VBoxContainer/Stat2/StatPoint
onready var pointsLabel3 = $Control/VBoxContainer/Stat3/StatPoint
onready var pointsLabel4 = $Control/VBoxContainer/Stat4/StatPoint
onready var pointsLabel5 = $Control/VBoxContainer/Stat5/StatPoint
onready var pointsLabel6 = $Control/VBoxContainer/Stat6/StatPoint

var uLose = false
var heroAgainst

var talentPoints = 0

func _ready():
	for p in RoomInfo.roundResult:
		if p.hero.lifePointsLose > p.hero.lifePoints:
			if p.hero.id == Persistence.data.hero.id:
				uLose = true
		if p.hero.id != Persistence.data.hero.id:
			heroAgainst = p.hero
	
	var experience = calculateExperienceEarned()
	
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

func calculateExperienceEarned():
	var lvDiference = Persistence.data.hero.level - heroAgainst.level
	
	return lvDiference * 20

func updateUi():
	pass
