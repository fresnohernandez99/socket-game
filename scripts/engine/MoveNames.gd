extends Node

const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")
const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")

func getMoveName(charClass: String, moveId: String):
	var moveNames = {
		ClassHandler.CLASS_BOX: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Puñetazo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Gancho",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Derecha-Izquierda",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Nudillera",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Guante con pinchos",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Cadena enrollada",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Puño de dragón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Puño de fuego",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Puño ganador",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Escuchar al entrenador",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Saltar suiza",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Práctica con saco",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar heridas",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Memorias",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Pose de tortuga",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Pose lateral",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Dureza",
		},
		
		ClassHandler.CLASS_ARCHER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Empujón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Cabezazo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Impulso",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Tiro certero",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Flecha con gancho",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Flecha de Hierro",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Flecha de fuego",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Flecha de elfo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Flecha explosiva",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "TOmar un respiro",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Aligerar la carga",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Aguantar disparo",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar Heridas",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Curación orisha",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Atrincherarse",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Medir distancias",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Escudo mineral",
		},
		
		ClassHandler.CLASS_SWORD_MASTER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Martillazo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Empujón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Derecha-Izquierda",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Puñalada",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Tajo",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Sin descanso",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Espada gemela",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Espada ultra afilada",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Corte final",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Tomar un respiro",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Aligerar la carga",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Gran espadón",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar heridas",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Memorias",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Sacar escudo",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Sacar armadura",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Dureza",
		},
		
		ClassHandler.CLASS_WIZARD: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Empujón",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Enganño",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Cabezazo",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Entumecer",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Enseñar una lección",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Espada y bastón. Tajo",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Liberar energía",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Tortura mental",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Fuego negro",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Concentración",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Meditación",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Empoderar magia",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Curación pequeña",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Curación perfecta",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Hechizo de intangibilidad",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Hechizo de escudo",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Barrera impenetrable",
		},
		
		ClassHandler.CLASS_NINJA: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Golpe por detrás",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Gancho",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Karate",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Shuriken",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Puñal",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Ataque de Katana",
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Golpe envainado",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Sello maldito",
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Katana sangrienta",
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Afinar los sentidos",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Mejora de velocidad no Jutsu",
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Mejora de fuerza no Jutsu",
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Bendage",
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Medicina",
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Intentar parry",
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Pose lateral",
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Pantalla de humo",
		}
	}
	
	var moveIdWithoutGrade = moveId.replace("-L1", "").replace("-L2", "").replace("-L3", "").replace("-LS", "")
	
	return moveNames[charClass][moveIdWithoutGrade]
