extends Node

const uuid_util = preload("res://scripts/engine/UID.gd")
const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")
const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")

func generateInitialHero():
	var heroId = uuid_util.v4()
	
	var classHandler = ClassHandler.new()
	
	var charClass = classHandler.getRandomClass()
	
	var stats = classHandler.getInitialStatsByClass(charClass.name)
	
	var equipment = classHandler.getInitialEquipments(charClass.name)
	
	var testMove21 = {
		"id": "attack" + "-" + "melee" + "-" + "1" + "-" + "L1",
		"damage": 2,
		"type": ["melee"]
	}
	
	var hero = {
		"id": heroId,
		"playerId": "",
		"level": 8,
		"experience": 0,
		"nextLevelOn": 100,
		"lifePoints": 100,
		"charClass": charClass,
		"stats": stats,
		"equipment": equipment,
		"moves": [testMove21]
	}
	
	var aux = MoveHandler.new().getNewMeleeAttack(hero)
	print("Melee random attack => ", aux)
	
	aux = MoveHandler.new().getNewWeaponAttack(hero)
	print("Melee random attack => ", aux)
	
	aux = MoveHandler.new().getNewMagicAttack(hero)
	print("Melee random attack => ", aux)
	#print(JSON.print(hero))

func setMultiplayerId():
	Persistence.data.hero.playerId = Session.playerId
