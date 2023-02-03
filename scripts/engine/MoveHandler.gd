extends Node

const ATTACK_MOVE = "attack"
const DEFENSE_MOVE = "defense"
const HEAL_MOVE = "heal"
const BOOST_MOVE = "boost"
const MAGIC_MOVE = "magic"
const INSTANT_HEAL_MOVE = "instant-heal"

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
		"damage": 11,
		"types": [ATTACK_TYPE_MELEE],
		"type": ATTACK_MOVE
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "2",
		"damage": 22,
		"types": [ATTACK_TYPE_MELEE],
		"type": ATTACK_MOVE
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MELEE + "-" + "3",
		"damage": 33,
		"types": [ATTACK_TYPE_MELEE],
		"type": ATTACK_MOVE
	}
]

var weaponsMoves = [
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "1",
		"damage": 11,
		"types": [ATTACK_TYPE_WEAPON],
		"type": ATTACK_MOVE
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "2",
		"damage": 22,
		"types": [ATTACK_TYPE_WEAPON],
		"type": ATTACK_MOVE
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_WEAPON + "-" + "3",
		"damage": 33,
		"types": [ATTACK_TYPE_WEAPON],
		"type": ATTACK_MOVE
	}
]

var magicMoves = [
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "1",
		"damage": 11,
		"types": [ATTACK_TYPE_MAGIC],
		"type": ATTACK_MOVE
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "2",
		"damage": 22,
		"types": [ATTACK_TYPE_MAGIC],
		"type": ATTACK_MOVE
	},
	{
		"id": ATTACK_MOVE + "-" + ATTACK_TYPE_MAGIC + "-" + "3",
		"damage": 33,
		"types": [ATTACK_TYPE_MAGIC],
		"type": ATTACK_MOVE
	}
]

var boostMoves = [
	{
		"id": BOOST_MOVE + "-" + BOOST_TO_INTELLECT + "-" + "1",
		"attrToBoost": 2,
		"value": 1,
		"type": BOOST_MOVE
	},
	{
		"id": BOOST_MOVE + "-" + BOOST_TO_SPEED + "-" + "1",
		"attrToBoost": 4,
		"value": 1,
		"type": BOOST_MOVE
	},
	{
		"id": BOOST_MOVE + "-" + BOOST_TO_STRENGTH + "-" + "1",
		"attrToBoost": 5,
		"value": 1,
		"type": BOOST_MOVE
	},
]

var healMove = [
	{
		"id": HEAL_MOVE + "-" + "1",
		"restoredPoints": 30,
		"type": HEAL_MOVE
	}
]

# TODO add on next version
var instantHealMove = [
	{
		"id": INSTANT_HEAL_MOVE + "-" + "1",
		"restoreLife": true,
		"uses": 1,
		"type": INSTANT_HEAL_MOVE
	}
]

var defenseMove = [
	{
		"id": DEFENSE_MOVE + "-" + "1",
		"percent": 0.1,
		"specific": false,
		"specificType": [ATTACK_TYPE_MELEE],
		"type": DEFENSE_MOVE
	},
	{
		"id": DEFENSE_MOVE + "-" + "2",
		"percent": 0.2,
		"specific": false,
		"specificType": [ATTACK_TYPE_WEAPON],
		"type": DEFENSE_MOVE
	},
	{
		"id": DEFENSE_MOVE + "-" + "3",
		"percent": 0.3,
		"specific": false,
		"specificType": [ATTACK_TYPE_MAGIC],
		"type": DEFENSE_MOVE
	}
]

# Tree for BOX, SwordMaster
var learningTree1 = [
	ATTACK_MOVE,
	ATTACK_MOVE,
	DEFENSE_MOVE,
	HEAL_MOVE,
	BOOST_MOVE,
	MAGIC_MOVE
]

# Tree for Archer, Ninja
var learningTree2 = [
	ATTACK_MOVE,
	BOOST_MOVE,
	DEFENSE_MOVE,
	ATTACK_MOVE,
	HEAL_MOVE,
	MAGIC_MOVE
]

# Tree for Wizard
var learningTree3 = [
	MAGIC_MOVE,
	ATTACK_MOVE,
	HEAL_MOVE,
	BOOST_MOVE,
	DEFENSE_MOVE,
	ATTACK_MOVE
]

func removeAlreadyTokeMoves(moves, arr, levelGrade):
	var cont = 0
	while(cont < moves.size()):
		var finding: String = moves[cont].id
		
		var cont2 = arr.size() -1
		while(cont2 >= 0):
			var finding2: String = arr[cont2].id
			
			if finding.find(finding2) != -1 and finding.find(levelGrade):
				arr.remove(cont2)
			
			cont2 -= 1
		
		cont += 1
	return arr

func getGrade(level):
	if level/10 >= 4:
		return LEVEL_GRADE_LS
	elif level/10 >= 3:
		return LEVEL_GRADE_L3
	elif level/10 >= 2:
		return LEVEL_GRADE_L2
	elif level/10 >= 0:
		return LEVEL_GRADE_L1

func generateInitialMoves(ClassHandler, hero):
	var arr
	match(hero.charClass.name):
		ClassHandler.CLASS_BOX:
			arr = [getNewMeleeOrWeaponAttack(hero), getNewMeleeOrWeaponAttack(hero)]
		ClassHandler.CLASS_ARCHER:
			arr = [getNewMeleeOrWeaponAttack(hero), getNewBoost(hero)]
		ClassHandler.CLASS_SWORD_MASTER:
			arr = [getNewMeleeOrWeaponAttack(hero), getNewMeleeOrWeaponAttack(hero)]
		ClassHandler.CLASS_WIZARD:
			arr = [getNewMagicAttack(hero), getNewBoost(hero)]
		ClassHandler.CLASS_NINJA:
			arr = [getNewMeleeOrWeaponAttack(hero), getNewBoost(hero)]
	return arr

func generateNextMove(ClassHandler, hero):
	var learningTreePos = str(hero.level)[str(hero.level).length() -1]
	
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
	
	var learningTree
	match(hero.charClass.name):
		ClassHandler.CLASS_BOX:
			learningTree = learningTree1
		ClassHandler.CLASS_ARCHER:
			learningTree = learningTree2
		ClassHandler.CLASS_SWORD_MASTER:
			learningTree = learningTree1
		ClassHandler.CLASS_WIZARD:
			learningTree = learningTree3
		ClassHandler.CLASS_NINJA:
			learningTree = learningTree2
	
	var newLearningStep = learningTree[toGetOn]
	
	match(newLearningStep):
		ATTACK_MOVE:
			return getNewMeleeOrWeaponAttack(hero)
		BOOST_MOVE:
			return getNewBoost(hero)
		DEFENSE_MOVE:
			return getNewDefense(hero)
		HEAL_MOVE:
			return getNewHeal(hero)
		MAGIC_MOVE:
			return getNewMagicAttack(hero)

func getNewMeleeOrWeaponAttack(hero):
	var rand = rand_range(0, 11)
	
	if rand > 5:
		return getNewMeleeAttack(hero)
	else:
		return getNewWeaponAttack(hero)

func getNewMeleeAttack(hero):
	if hero.level == 1:
		var selected = meleeMoves[int(rand_range(0, meleeMoves.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade = getGrade(hero.level)
	
	var arr = removeAlreadyTokeMoves(hero.moves, meleeMoves, levelGrade)
	
	if arr.size() > 0:
		var selected = arr[int(rand_range(0, arr.size()))]
		selected.id += "-" + levelGrade
		return selected
	else:
		return null

func getNewWeaponAttack(hero):
	if hero.level == 1:
		var selected = weaponsMoves[int(rand_range(0, weaponsMoves.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade = getGrade(hero.level)
	
	var arr = removeAlreadyTokeMoves(hero.moves, weaponsMoves, levelGrade)
	
	if arr.size() > 0:
		var selected = arr[int(rand_range(0, arr.size()))]
		selected.id += "-" + levelGrade
		return selected
	else:
		return null

func getNewMagicAttack(hero):
	if hero.level == 1:
		var selected = magicMoves[int(rand_range(0, magicMoves.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade = getGrade(hero.level)
	
	var arr = removeAlreadyTokeMoves(hero.moves, magicMoves, levelGrade)
	
	if arr.size() > 0:
		var selected = arr[int(rand_range(0, arr.size()))]
		selected.id += "-" + levelGrade
		return selected
	else:
		return null

func getNewBoost(hero):
	if hero.level == 1:
		var selected = boostMoves[int(rand_range(0, boostMoves.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade = getGrade(hero.level)
	
	var arr = removeAlreadyTokeMoves(hero.moves, boostMoves, levelGrade)
	
	if arr.size() > 0:
		var selected = arr[int(rand_range(0, arr.size()))]
		selected.id += "-" + levelGrade
		return selected
	else:
		return null

func getNewDefense(hero):
	if hero.level == 1:
		var selected = defenseMove[int(rand_range(0, defenseMove.size()))]
		selected.id += "-" + LEVEL_GRADE_L1
		return selected
	
	if hero.level == 2:
		return null
	
	var levelGrade = getGrade(hero.level)
	
	var arr = removeAlreadyTokeMoves(hero.moves, defenseMove, levelGrade)
	
	if arr.size() > 0:
		var selected = arr[int(rand_range(0, arr.size()))]
		selected.id += "-" + levelGrade
		return selected
	else:
		return null

func getNewHeal(hero):
	# solamente para mas de level 10
	var levelGrade = getGrade(hero.level)
	var power = hero.level / 10
	
	var move = healMove[0]
	
	if power > 0:
		move.restoredPoints *= power
	
	return move

func getInstantHeal(hero):
	# solamente para mas de level 10
	var levelGrade = getGrade(hero.level)
	var uses = (hero.level / 10) - 5 
	
	var move = instantHealMove[0]
	move.uses = uses
	
	return move















