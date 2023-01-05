extends Node

func getMoveName(ClassHandler, MoveHandler, charClass: String, moveId: String):
	var moveNames = {
		ClassHandler.CLASS_BOX: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Puñetazo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Gancho",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Derecha-Izquierda",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Golpe de nudillera",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Guantes con púas",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Cadena enroscada",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Puño del dragón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Puño de fuego",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Puño de victoria",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Escuchar al entrenador",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Saltar suiza",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Práctica con saco",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar heridas",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Recuerdos",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Pose tortuga",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Posición lateral",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Endurecimiento",
		},
		
		ClassHandler.CLASS_ARCHER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Empujón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Cabezazo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Impulso",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Tiro al blanco",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Flecha con gancho",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Flecha de hierro",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Flecha de fuego",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Flecha de elfo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Flecha explosiva",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Tomar aire",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Aligerar carga",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Aguantar disparo",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar heridas",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Curación élfica",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Atrincherar",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Medir distancia",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Escudo mineral",
		},
		
		ClassHandler.CLASS_SWORD_MASTER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Golpe martillo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Empujón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Derecha-Izquierda",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Estocada",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Tajo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Sin descanzo",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Espada gemela",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Espada ultrafilada",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Corte final",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Tomar aire",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Aligerar carga",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Usar mandoble",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar heridas",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Recuerdos",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Sacar escudo",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Usar armadura",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Endurecimiento",
		},
		
		ClassHandler.CLASS_WIZARD: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Empujón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Engaño",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Cabezazo",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Entumecer",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Enseñar lección",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Báculo y espada. Tajo.",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Energía desatada",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Tortura mental",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Fuego negro",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Concentración",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Meditar",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Magia potenciadora",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Curación temporal",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Curación perfeccionada",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Hechizo de intangibilidad",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Hechizo de escudo",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Barrera imprenetrable",
		},
		
		ClassHandler.CLASS_NINJA: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Golpe por la espalda",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Gancho",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Karate",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Shuriken",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Cuchillos pequeños",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Golpe de katana",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Golpe y envainar",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Sello maldito",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Katana ensangrentada",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Afinar sentidos",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Jutsu de potenciación de velocidad",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Jutsu de potenciación de fuerza",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Vendar",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Medicina",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Try parry",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Posición lateral",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Cortina de humo",
		}
	}
	
	var moveIdWithoutGrade = moveId.replace("-L1", "").replace("-L2", "").replace("-L3", "").replace("-LS", "")
	
	return moveNames[charClass][moveIdWithoutGrade]
