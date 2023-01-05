extends Node

const STAT_DEFENSE = "defense" #0
const STAT_EVASION = "evasion" #1
const STAT_INTELLECT = "intellect" #2
const STAT_MAGIC = "magic" #3
const STAT_SPEED = "speed" #4
const STAT_STRENGTH = "strength" #5


func _ready():
	randomize()

var stats = [
	{
		"name": STAT_DEFENSE,
		"value": 1.0
	},
	{
		"name": STAT_EVASION,
		"value": 1.0
	},
	{
		"name": STAT_INTELLECT,
		"value": 1.0
	},
	{
		"name": STAT_MAGIC,
		"value": 1.0
	},
	{
		"name": STAT_SPEED,
		"value": 1.0
	},
	{
		"name": STAT_STRENGTH,
		"value": 1.0
	}
]

const CLASS_BOX = "box" #0
const CLASS_ARCHER = "archer" #1
const CLASS_SWORD_MASTER = "sword_master" #2
const CLASS_WIZARD = "wizard" #3
const CLASS_NINJA = "ninja" #3

var classes = [
	{
		"name": CLASS_BOX,
		"poweredStat":  [STAT_STRENGTH]
	},
	{
		"name": CLASS_ARCHER,
		"poweredStat":  [STAT_SPEED, STAT_EVASION]
	},
	{
		"name": CLASS_SWORD_MASTER,
		"poweredStat":  [STAT_STRENGTH, STAT_EVASION]
	},
	{
		"name": CLASS_WIZARD,
		"poweredStat":  [STAT_MAGIC, STAT_INTELLECT]
	},
	{
		"name": CLASS_NINJA,
		"poweredStat":  [STAT_EVASION]
	}
]

func getRandomClass():
	return classes[int(rand_range(0, classes.size()))]
	
func getInitialStatsByClass(classGiven):
	var positionOfClass
	
	match classGiven:
		CLASS_BOX:
			positionOfClass = 0
		CLASS_ARCHER:
			positionOfClass = 1
		CLASS_SWORD_MASTER:
			positionOfClass = 2
		CLASS_WIZARD:
			positionOfClass = 3
		CLASS_NINJA :
			positionOfClass = 4
	
	var cont = 0
	while(cont < classes[positionOfClass].poweredStat.size()):
		var actualStatToBoost = classes[positionOfClass].poweredStat[cont]
		
		var pointsToSplit = [ 1, 1.5, 2]
		var pointsToSplitSelected = pointsToSplit[int(rand_range(0, pointsToSplit.size()))]
		
		var cont2 = 0
		while(cont2 < stats.size()):
			if actualStatToBoost == stats[cont2].name:
				stats[cont2].value += pointsToSplitSelected
			
			cont2 +=1
		
		cont +=1
	return stats
