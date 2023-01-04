extends Node

const uuid_util = preload("res://scripts/engine/UID.gd")
const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")
const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")
const InitialEquipments = preload("res://scripts/engine/InitialEquipments.gd")
const MoveNames = preload("res://scripts/engine/MoveNames.gd")

func generateInitialHero():
	var heroId = uuid_util.v4()
	
	var classHandler = ClassHandler.new()
	var moveHandler = MoveHandler.new()
	var moveNames = MoveNames.new()
	var initialEquipments = InitialEquipments.new()
	
	var charClass = classHandler.getRandomClass()
	
	var stats = classHandler.getInitialStatsByClass(charClass.name)
	
	var equipment = initialEquipments.getInitialEquipments(classHandler, charClass.name)
	
	var testMove21 = {
		"id": "attack" + "-" + "melee" + "-" + "1" + "-" + "L1",
		"damage": 2,
		"type": ["melee"]
	}
	
	var hero = {
		"id": heroId,
		"playerId": "",
		"level": 1,
		"experience": 0,
		"nextLevelOn": 100,
		"lifePoints": 100,
		"charClass": charClass,
		"stats": stats,
		"equipment": equipment,
		"moves": []
	}
	
	hero.moves = moveHandler.generateInitialMoves(classHandler, hero)
	
	#print(JSON.print(hero))
	
	#for i in range(hero.moves.size()):
		#print(moveNames.getMoveName(classHandler, moveHandler, hero.charClass.name, hero.moves[i].id))

func setMultiplayerId():
	Persistence.data.hero.playerId = Session.playerId
