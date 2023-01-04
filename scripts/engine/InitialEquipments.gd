extends Node


var EQUIPMENT_TYPE_HEAD = "head"
var EQUIPMENT_TYPE_HANDS = "hands"
var EQUIPMENT_TYPE_TORSO = "torso"
var EQUIPMENT_TYPE_FOOTS = "foots"
var EQUIPMENT_TYPE_WEAPON = "weapon"
var EQUIPMENT_TYPE_EXTRA = "extra"

var initialHeads = [
	{
		"id": "1",
		"name": "Head 1", 
		"type": EQUIPMENT_TYPE_HEAD,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "Head 2", 
		"type": EQUIPMENT_TYPE_HEAD,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "Head 3", 
		"type": EQUIPMENT_TYPE_HEAD,
		"info": '{"rarity": 1 }'
	}
]

var initialHands = [
	{
		"id": "1",
		"name": "HANDS 1", 
		"type": EQUIPMENT_TYPE_HANDS,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "HANDS 2", 
		"type": EQUIPMENT_TYPE_HANDS,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "HANDS 3", 
		"type": EQUIPMENT_TYPE_HANDS,
		"info": '{"rarity": 1 }'
	}
]

var initialTorso = [
	{
		"id": "1",
		"name": "TORSO 1", 
		"type": EQUIPMENT_TYPE_TORSO,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "TORSO 2", 
		"type": EQUIPMENT_TYPE_TORSO,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "TORSO 3", 
		"type": EQUIPMENT_TYPE_TORSO,
		"info": '{"rarity": 1 }'
	}
]

var initialFoots = [
	{
		"id": "1",
		"name": "FOOTS 1", 
		"type": EQUIPMENT_TYPE_FOOTS,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "FOOTS 2", 
		"type": EQUIPMENT_TYPE_FOOTS,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "FOOTS 3", 
		"type": EQUIPMENT_TYPE_FOOTS,
		"info": '{"rarity": 1 }'
	}
]

var initialWeaponsForBox = [
	{
		"id": "1",
		"name": "Weapon for box 1", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "Weapon for box 2", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "Weapon for box 3", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	}
]

var initialWeaponsForArcher = [
	{
		"id": "1",
		"name": "Weapon for archer 1", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "Weapon for archer 2", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "Weapon for archer 3", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	}
]

var initialWeaponsForSwordMaster = [
	{
		"id": "1",
		"name": "Weapon for sm 1", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "Weapon for sm 2", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "Weapon for sm 3", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	}
]

var initialWeaponsForWizard = [
	{
		"id": "1",
		"name": "Weapon for wizard 1", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "Weapon for wizard 2", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "Weapon for wizard 3", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	}
]

var initialWeaponsForNinja = [
	{
		"id": "1",
		"name": "Weapon for ninja 1", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "2",
		"name": "Weapon for ninja 2", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	},
	{
		"id": "3",
		"name": "Weapon for ninja 3", 
		"type": EQUIPMENT_TYPE_WEAPON,
		"info": '{"rarity": 1 }'
	}
]

func getInitialEquipments(ClassHandler, classGiven):
	var byClass
	match classGiven:
		ClassHandler.CLASS_BOX:
			byClass = initialWeaponsForBox[int(rand_range(0, initialWeaponsForBox.size()))]
		ClassHandler.CLASS_ARCHER:
			byClass = initialWeaponsForArcher[int(rand_range(0, initialWeaponsForArcher.size()))]
		ClassHandler.CLASS_SWORD_MASTER:
			byClass = initialWeaponsForSwordMaster[int(rand_range(0, initialWeaponsForSwordMaster.size()))]
		ClassHandler.CLASS_WIZARD:
			byClass = initialWeaponsForWizard[int(rand_range(0, initialWeaponsForWizard.size()))]
		ClassHandler.CLASS_NINJA :
			byClass = initialWeaponsForNinja[int(rand_range(0, initialWeaponsForNinja.size()))]
		
	var generated = [
		initialHeads[int(rand_range(0, initialHeads.size()))],
		initialHands[int(rand_range(0, initialHands.size()))],
		initialTorso[int(rand_range(0, initialTorso.size()))],
		initialFoots[int(rand_range(0, initialFoots.size()))],
		byClass
	]
	
	return generated

