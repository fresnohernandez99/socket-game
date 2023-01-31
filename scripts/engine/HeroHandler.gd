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

func generateInitialHero():
	var heroId = uuid_util.v4()
	
	var charClass = classHandler.getRandomClass()
	
	var stats = classHandler.getInitialStatsByClass(charClass.name)
	
	var equipment = initialEquipments.getInitialEquipments(classHandler, charClass.name)
	
	var hero = {
		"id": heroId,
		"playerId": "",
		"position": "",
		"type": "hero",
		"name": Session.playerName,
		"level": 1,
		"experience": 0,
		"nextLevelOn": 100,
		"lifePoints": 25,
		"lifePointsLose": 0,
		"charClass": charClass,
		"stats": stats,
		"equipment": equipment,
		"moves": []
	}
	
	hero.moves = moveHandler.generateInitialMoves(classHandler, hero)
	
	return hero

func getMoveName(moveId, charClassName):
	return moveNames.getMoveName(charClassName, moveId)

func setMultiplayerId():
	Persistence.data.hero.playerId = Session.playerId
