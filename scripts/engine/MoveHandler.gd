extends Node

const ATTACK_MOVE = "attack"
const DEFENSE_MOVE = "defense"
const HEAL_MOVE = "heal"
const BOOST_MOVE = "boost"
const MAGIC_MOVE = "magic"
const INSTANT_HEAL_MOVE = "instant_heal"

const ATTACK_TYPE_MELEE = "melee"
const ATTACK_TYPE_WEAPON = "weapon"
const ATTACK_TYPE_MAGIC = "magic"

const BOOST_TO_INTELLECT = "intellect"
const BOOST_TO_SPEED = "speed"
const BOOST_TO_STRENGTH = "strength"

const LEVEL_GRADE_L1 = "L1"
const LEVEL_GRADE_L2 = "L2" 
const LEVEL_GRADE_L3 = "L3" 
const LEVEL_GRADE_LS = "LS" 

func _ready():
	randomize()

var meleeMoves = [
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "1",
		"damage": 1,
		"type": [ATTACK_TYPE_MELEE]
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "2",
		"damage": 2,
		"type": [ATTACK_TYPE_MELEE]
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "3",
		"damage": 3,
		"type": [ATTACK_TYPE_MELEE]
	}
]

var weaponsMoves = [
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "1",
		"damage": 1,
		"type": [ATTACK_TYPE_WEAPON]
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "2",
		"damage": 2,
		"type": [ATTACK_TYPE_WEAPON]
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "3",
		"damage": 3,
		"type": [ATTACK_TYPE_WEAPON]
	}
]

var magicMoves = [
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "1",
		"damage": 1,
		"type": [ATTACK_TYPE_MAGIC]
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "2",
		"damage": 2,
		"type": [ATTACK_TYPE_MAGIC]
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "3",
		"damage": 3,
		"type": [ATTACK_TYPE_MAGIC]
	}
]

var boostMoves = [
	{
		"id": BOOST_MOVE + "-" + BOOST_TO_INTELLECT + "-" + "1",
		"attrToBoost": 2,
		"value": 1
	},
	{
		"id": BOOST_MOVE + "-" + BOOST_TO_SPEED + "-" + "1",
		"attrToBoost": 4,
		"value": 1
	},
	{
		"id": BOOST_MOVE + "-" + BOOST_TO_STRENGTH + "-" + "1",
		"attrToBoost": 5,
		"value": 1
	},
]

var healMove = [
	{
		"id": HEAL_MOVE + "-" + "1",
		"restoredPoints": 1
	}
]

var instantHealMove = [
	{
		"id": INSTANT_HEAL_MOVE + "-" + "1",
		"restoredPoints": 1
	}
]

var meleeDefenseMove = [
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "1",
		"percent": 1,
		"specific": true,
		"specificType": [ATTACK_TYPE_MELEE]
	},
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "2",
		"percent": 2,
		"specific": true,
		"specificType": [ATTACK_TYPE_MELEE]
	},
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "3",
		"percent": 3,
		"specific": true,
		"specificType": [ATTACK_TYPE_MELEE]
	}
]

var weaponDefenseMove = [
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "1",
		"percent": 1,
		"specific": true,
		"specificType": [ATTACK_TYPE_WEAPON]
	},
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "2",
		"percent": 2,
		"specific": true,
		"specificType": [ATTACK_TYPE_WEAPON]
	},
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "3",
		"percent": 3,
		"specific": true,
		"specificType": [ATTACK_TYPE_WEAPON]
	}
]

var magicDefenseMove = [
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "1",
		"percent": 1,
		"specific": true,
		"specificType": [ATTACK_TYPE_MAGIC]
	},
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "2",
		"percent": 2,
		"specific": true,
		"specificType": [ATTACK_TYPE_MAGIC]
	},
	{
		"id": DEFENSE_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "3",
		"percent": 3,
		"specific": true,
		"specificType": [ATTACK_TYPE_MAGIC]
	}
]

var learningTree1 = [
	ATTACK_MOVE,
	ATTACK_MOVE,
	DEFENSE_MOVE,
	HEAL_MOVE,
	BOOST_MOVE,
	MAGIC_MOVE
]

func removeAlreadyTokeMoves(moves, arr):
	var cont = 0
	while(cont < moves.size()):
		var finding: String = moves[cont].id
		
		var cont2 = arr.size() -1
		while(cont2 >= 0):
			var finding2: String = arr[cont2].id
			
			if finding.find(finding2) != -1:
				arr.remove(cont2)
			
			cont2 -= 1
		
		cont += 1
	return arr

func generateNextMove(ClassHandler, charClass, level):
	var learningTreePos = str(level)[str(level).length() -1]
	
	var toGetOn
	match(int(learningTreePos)):
		1, 3, 5, 7, 9:
			return null
		2:
			toGetOn = 0
		4:
			toGetOn = 1
		6:
			toGetOn = 2
		8:
			toGetOn = 3
		0:
			toGetOn = 4

func generateInitialMoves(ClassHandler, charClass):
	match(charClass.name):
		ClassHandler.CLASS_BOX:
			pass
		ClassHandler.CLASS_ARCHER:
			pass
		ClassHandler.CLASS_SWORD_MASTER:
			pass
		ClassHandler.CLASS_WIZARD:
			pass
		ClassHandler.CLASS_NINJA:
			pass

func getNewMeleeAttack(hero):
	if hero.level == 1:
		var selected = meleeMoves[int(rand_range(0, meleeMoves.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade
	if hero.level/10 >= 4:
		levelGrade = LEVEL_GRADE_LS
	elif hero.level/10 >= 3:
		hero.levelGrade = LEVEL_GRADE_L3
	elif hero.level/10 >= 2:
		levelGrade = LEVEL_GRADE_L2
	elif hero.level/10 >= 0:
		levelGrade = LEVEL_GRADE_L1
	
	var arr = removeAlreadyTokeMoves(hero.moves, meleeMoves)
	
	var selected = arr[int(rand_range(0, arr.size()))]
	selected.id += "-" + levelGrade
	return selected
	

func getNewWeaponAttack(hero):
	if hero.level == 1:
		var selected = weaponsMoves[int(rand_range(0, weaponsMoves.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade
	if hero.level/10 >= 4:
		levelGrade = LEVEL_GRADE_LS
	elif hero.level/10 >= 3:
		hero.levelGrade = LEVEL_GRADE_L3
	elif hero.level/10 >= 2:
		levelGrade = LEVEL_GRADE_L2
	elif hero.level/10 >= 0:
		levelGrade = LEVEL_GRADE_L1
	
	var arr = removeAlreadyTokeMoves(hero.moves, weaponsMoves)
	
	var selected = arr[int(rand_range(0, arr.size()))]
	selected.id += "-" + levelGrade
	return selected

func getNewMagicAttack(hero):
	if hero.level == 1:
		var selected = magicMoves[int(rand_range(0, magicMoves.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade
	if hero.level/10 >= 4:
		levelGrade = LEVEL_GRADE_LS
	elif hero.level/10 >= 3:
		hero.levelGrade = LEVEL_GRADE_L3
	elif hero.level/10 >= 2:
		levelGrade = LEVEL_GRADE_L2
	elif hero.level/10 >= 0:
		levelGrade = LEVEL_GRADE_L1
	
	var arr = removeAlreadyTokeMoves(hero.moves, magicMoves)
	
	var selected = arr[int(rand_range(0, arr.size()))]
	selected.id += "-" + levelGrade
	return selected




















