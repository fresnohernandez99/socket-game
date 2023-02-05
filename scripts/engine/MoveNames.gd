extends Node

const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")
const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")

func getMoveName(charClass: String, moveId: String):
	var moveNames = {
		ClassHandler.CLASS_BOX: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Puñetazo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Gancho" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Derecha-Izquierda" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Nudillera" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Guante con pinchos" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Cadena enrollada" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Puño de dragón" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Puño de fuego" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Puño ganador" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Escuchar al entrenador" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Saltar suiza" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Práctica con saco" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar heridas" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Memorias" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Pose de tortuga" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Pose lateral" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Dureza" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
		},
		
		ClassHandler.CLASS_ARCHER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Empujón" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Cabezazo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Impulso" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Tiro certero" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Flecha con gancho" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Flecha de Hierro" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Flecha de fuego" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Flecha de elfo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Flecha explosiva" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "TOmar un respiro" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Aligerar la carga" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Aguantar disparo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar Heridas" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Curación orisha" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Atrincherarse" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Medir distancias" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Escudo mineral" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
		},
		
		ClassHandler.CLASS_SWORD_MASTER: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Martillazo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Empujón" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Derecha-Izquierda" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Puñalada" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Tajo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Sin descanso" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Espada gemela" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Espada ultra afilada" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Corte final" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Tomar un respiro" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Aligerar la carga" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Gran espadón" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Limpiar heridas" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Memorias" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Sacar escudo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Sacar armadura" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Dureza" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
		},
		
		ClassHandler.CLASS_WIZARD: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Empujón" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Enganño" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Cabezazo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Entumecer" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Enseñar una lección" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Espada y bastón. Tajo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Liberar energía" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Tortura mental" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Fuego negro" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Concentración" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Meditación" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Empoderar magia" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Curación pequeña" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Curación perfecta" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Hechizo de intangibilidad" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Hechizo de escudo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Barrera impenetrable" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
		},
		
		ClassHandler.CLASS_NINJA: {
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "1": "Golpe por detrás" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "2": "Gancho" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MELEE + "-" + "3": "Karate" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "1": "Shuriken" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "2": "Puñal" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_WEAPON + "-" + "3": "Ataque de Katana" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "1": "Golpe envainado" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "2": "Sello maldito" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.ATTACK_MOVE + "-" + MoveHandler.ATTACK_TYPE_MAGIC + "-" + "3": "Katana sangrienta" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_INTELLECT + "-" + "1": "Afinar los sentidos" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_SPEED  + "-" + "1": "Mejora de velocidad no Jutsu" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.BOOST_MOVE + "-" + MoveHandler.BOOST_TO_STRENGTH + "-" + "1": "Mejora de fuerza no Jutsu" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.HEAL_MOVE + "-" + "1": "Bendage" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.INSTANT_HEAL_MOVE + "-" + "1": "Medicina" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			
			MoveHandler.DEFENSE_MOVE + "-" + "1": "Intentar parry" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "2": "Pose lateral" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
			MoveHandler.DEFENSE_MOVE + "-" + "3": "Pantalla de humo" + " " + moveId[moveId.length() -2] + moveId[moveId.length() -1],
		}
	}
	
	var moveIdWithoutGrade = moveId.replace("-L1", "").replace("-L2", "").replace("-L3", "").replace("-LS", "")
	
	return moveNames[charClass][moveIdWithoutGrade]
