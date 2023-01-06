extends Node

func getMoveName(ClassHandler, MoveHandler, charClass: String, moveId: String):
	var moveNames = {
		ClassHandler.CLASS_BOX: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Punch",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Hook",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Right-Left",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Knuckle stroke",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Spiky gloves",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Winded chain",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Dragon Fist",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Fire Fist",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Winning Fist",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Listen to the trainer",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Jump the rope",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Bag prectice",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Clean wounds",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Memories",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Turtle pose",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Lateral pose",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Toughness",
		},
		
		ClassHandler.CLASS_ARCHER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Push",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Head Knock",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Impulse",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Diana shooting",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Hook arrow",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Iron arrow",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Fire arrow",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Elf arrow",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Explosive arrow",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Take a breath",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Lighten load",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Hold shot",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Clean wounds",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Elven healing",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Trench",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Measure distance",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Mineral shield",
		},
		
		ClassHandler.CLASS_SWORD_MASTER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Hammer Knock",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Push",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Right-Left",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Stab",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Hack",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Without rest",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Twin Swords",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Ultra sharp sword",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Final cut",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Take a breath",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Lighten load",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Greatsword",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Clean wounds",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Memories",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Pull out shield",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Pull out armor",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Toughness",
		},
		
		ClassHandler.CLASS_WIZARD: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Push",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Cheated",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Head Knock",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Numb",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Teach lesson",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Staff & sword. Hack.",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Unleashed energy",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Mental torture",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Black fire",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Focus",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Meditate",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Enhancer magic",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Temporary healing",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Perfected healing",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Intangibility spell",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Shield spell",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Impenetrable barrier",
		},
		
		ClassHandler.CLASS_NINJA: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Blow from behind",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Hook",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Karate",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Shuriken",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Short knives",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Katana strike",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Punch & sheath",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Cursed seal",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Gory katana",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Tune up senses",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Speed boost Jutsu",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Strength boost Jutsu",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Bandage",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Medicine",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Try parry",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Lateral pose",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Smokescreen",
		}
	}
	
	var moveIdWithoutGrade = moveId.replace("-L1", "").replace("-L2", "").replace("-L3", "").replace("-LS", "")
	
	return moveNames[charClass][moveIdWithoutGrade]
