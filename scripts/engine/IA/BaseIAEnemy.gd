extends Node


const uuid_util = preload("res://scripts/engine/UID.gd")
const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")
const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")
const InitialEquipments = preload("res://scripts/engine/InitialEquipments.gd")
const MoveNames = preload("res://scripts/engine/MoveNames.gd")

var classHandler = ClassHandler.new()
var moveHandler = MoveHandler.new()
var moveNames = MoveNames.new()
var initialEquipments = InitialEquipments.new()

func _ready():
	randomize()

func getNewNpc(name: String, level: int):
	var heroId = uuid_util.v4()
	var charClass = classHandler.getRandomClass()
	var stats = classHandler.getInitialStatsByClass(charClass.name)
	var equipment = initialEquipments.getInitialEquipments(classHandler, charClass.name)
	
	var IAHero = {
					"id": "IA",
					"playerId": "",
					"position": "",
					"type": "hero",
					"name": name,
					"level": 1,
					"experience": 0,
					"nextLevelOn": 100,
					"lifePoints": 100,
					"lifePointsLose": 0,
					"charClass": charClass,
					"stats": stats,
					"equipment": equipment,
					"moves": []
				}
	
	IAHero.moves = moveHandler.generateInitialMoves(classHandler, IAHero)
	
	IAHero.level = level
	
	var talentPoints = level / 2
	while talentPoints != 0:
		var selected = int(rand_range(0, IAHero.stats.size()))
		IAHero.stats[selected].value += 1
		talentPoints -= 1
	
	if level > 1 && level < 10:
		var newPower1 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower1 != null:
			IAHero.moves.push_back(newPower1)
		
		var newPower2 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower2 != null:
			IAHero.moves.push_back(newPower2)
	elif level >= 10 && level < 20:
		var newPower1 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower1 != null:
			IAHero.moves.push_back(newPower1)
		
		var newPower2 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower2 != null:
			IAHero.moves.push_back(newPower2)
		
		var newPower3 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower3 != null:
			IAHero.moves[0] = newPower3
	elif level >= 20 && level < 30:
		var newPower1 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower1 != null:
			IAHero.moves.push_back(newPower1)
		
		var newPower2 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower2 != null:
			IAHero.moves.push_back(newPower2)
		
		var newPower3 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower3 != null:
			IAHero.moves[0] = newPower3
			
		var newPower4 = moveHandler.generateNextMove(classHandler, IAHero)
		if newPower4 != null:
			IAHero.moves[1] = newPower4
	
	IAHero.lifePoints += classHandler.upgradeLife(IAHero)
	
	var IA = {
		"name": name,
		"playerId": "IA",
		"handDeck": {
			"name": "hand-deck",
				"items": [
					IAHero
				]
		}
	}
	
	return IA
