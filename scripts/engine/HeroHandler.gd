extends Node

const uuid_util = preload("res://scripts/engine/UID.gd")
const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")

func generateInitialHero():
	var heroId = uuid_util.v4()
	
	var classHandler = ClassHandler.new()
	
	var charClass = classHandler.getRandomClass()
	
	var stats = classHandler.getInitialStatsByClass(charClass.name)
	
	var equipment = classHandler.getInitialEquipments(charClass.name)
	
	var hero = {
		"id": heroId,
		"playerId": "",
		"level": 1,
		"lifePoints": 100,
		"charClass": charClass,
		"stats": stats,
		"equipment": equipment
	}
	
	print(JSON.print(hero))

func setMultiplayerId():
	Persistence.data.hero.playerId = Session.playerId
