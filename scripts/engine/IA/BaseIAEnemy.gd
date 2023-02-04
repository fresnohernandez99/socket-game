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
					"level": level,
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
	
	var talentPoints = level / 2
	while talentPoints != 0:
		var selected = int(rand_range(0, IAHero.stats.size()))
		IAHero.stats[selected].value += 1
		talentPoints -= 1
		
	if level > 1 && level < 10:
		IAHero.moves.push_back(moveHandler.generateNextMove(classHandler, IAHero))
		IAHero.moves.push_back(moveHandler.generateNextMove(classHandler, IAHero))
	elif level >= 10 && level < 20:
		IAHero.moves[0] = moveHandler.generateNextMove(classHandler, IAHero)
		IAHero.moves.push_back(moveHandler.generateNextMove(classHandler, IAHero))
		IAHero.moves.push_back(moveHandler.generateNextMove(classHandler, IAHero))
	elif level >= 20 && level < 30:
		IAHero.moves[0] = moveHandler.generateNextMove(classHandler, IAHero)
		IAHero.moves[1] = moveHandler.generateNextMove(classHandler, IAHero)
		IAHero.moves.push_back(moveHandler.generateNextMove(classHandler, IAHero))
		IAHero.moves.push_back(moveHandler.generateNextMove(classHandler, IAHero))
	
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
