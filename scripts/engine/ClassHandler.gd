extends Node

const STAT_DEFENSE = "defense" #0
const STAT_EVASION = "evasion" #1
const STAT_INTELLECT = "intellect" #2
const STAT_MAGIC = "magic" #3
const STAT_SPEED = "speed" #4
const STAT_STRENGTH = "strength" #5


func _ready():
	randomize()

var stats = [
	{
		"name": STAT_DEFENSE, #influye restando damage al atake recibido
		"value": 1.0
	},
	{
		"name": STAT_EVASION, #influye en la probabilidad de miss
		"value": 1.0
	},
	{
		"name": STAT_INTELLECT, #influye en un atake
		"value": 1.0
	},
	{
		"name": STAT_MAGIC, #no influye en nada en esta ocasión
		"value": 1.0
	},
	{
		"name": STAT_SPEED, #influye en un atake, influye en kien ataka primero
		"value": 1.0
	},
	{
		"name": STAT_STRENGTH, #influye en un atake
		"value": 1.0
	}
]

const CLASS_BOX = "box" #0
const CLASS_ARCHER = "archer" #1
const CLASS_SWORD_MASTER = "sword_master" #2
const CLASS_WIZARD = "wizard" #3
const CLASS_NINJA = "ninja" #3

var classes = [
	{
		"name": CLASS_BOX,
		"poweredStat":  [STAT_STRENGTH]
	},
	{
		"name": CLASS_ARCHER,
		"poweredStat":  [STAT_SPEED, STAT_EVASION]
	},
	{
		"name": CLASS_SWORD_MASTER,
		"poweredStat":  [STAT_STRENGTH, STAT_EVASION]
	},
	{
		"name": CLASS_WIZARD,
		"poweredStat":  [STAT_MAGIC, STAT_INTELLECT]
	},
	{
		"name": CLASS_NINJA,
		"poweredStat":  [STAT_EVASION]
	}
]

func getColorByClass(hero):
	var color
	match hero.charClass.name:
		CLASS_BOX:
			color = Color.red
		CLASS_ARCHER:
			color = Color.antiquewhite
		CLASS_SWORD_MASTER:
			color = Color.darkgray
		CLASS_WIZARD:
			color = Color.aqua
		CLASS_NINJA :
			color = Color.black
	return color

func getSpritePosByClass(hero):
	var spritePos
	match hero.charClass.name:
		CLASS_BOX:
			spritePos = 0
		CLASS_ARCHER:
			spritePos = 1
		CLASS_SWORD_MASTER:
			spritePos = 2
		CLASS_WIZARD:
			spritePos = 3
		CLASS_NINJA :
			spritePos = 4
	return spritePos

func getClassName(hero):
	var className
	match hero.charClass.name:
		CLASS_BOX:
			className = "Hércules"
		CLASS_ARCHER:
			className = "Ochosi"
		CLASS_SWORD_MASTER:
			className = "Gilbert Hérail"
		CLASS_WIZARD:
			className = "Veles"
		CLASS_NINJA :
			className = "Susanoo"
	return className

func getClassDescription(hero):
	var description
	match hero.charClass.name:
		CLASS_BOX:
			description = "Un héroe solitario y peregrino, que combate a los monstruos y realiza hazañas extraordinarias. Su fuerza destaca sobre sus muchas cualidades heróicas."
		CLASS_ARCHER:
			description = "El mejor de los cazadores y uno de los guerreros. Es el santo de las prisiones, Orisha de la cárcel, la justicia y los perseguidos."
		CLASS_SWORD_MASTER:
			description = "Uno de los templarios más jóvenes. Alistado muy joven y fuerte con la espada y de liderazgo excepcional."
		CLASS_WIZARD:
			description = "Astuto y travieso. Podía transformarse en árbol, animal o incluso persona para protegerse."
		CLASS_NINJA :
			description = "De gran talento pero rebelde y agresivo estaba inconforme con los dones que le entregó su padre. Le concedió el mar, la tierra y el rayo, pero quería más."
	return description

func getClassGodImage(hero):
	var image
	match hero.charClass.name:
		CLASS_BOX:
			image = "res://assets/imgs/gods/hercules.jpg"
		CLASS_ARCHER:
			image = "res://assets/imgs/gods/ochosi.png"
		CLASS_SWORD_MASTER:
			image = "res://assets/imgs/gods/templar.jpeg"
		CLASS_WIZARD:
			image = "res://assets/imgs/gods/veles.jpg"
		CLASS_NINJA :
			image = "res://assets/imgs/gods/susanoo.png"
	return image

func _getStatName(stat: int):
	var statName = ""
	match stat:
		0:
			statName = "Defensa"
		1:
			statName = "Evasión"
		2:
			statName = "Intelecto"
		3:
			statName = "Magia"
		4:
			statName = "Velocidad"
		5:
			statName = "Fuerza"
	return statName

func _getStatPosByName(statName):
	var statPos = 0
	match statName:
		"defense":
			statPos = 0
		"evasion":
			statPos = 1
		"intellect":
			statPos = 2
		"magic":
			statPos = 3
		"speed":
			statPos = 4
		"strength":
			statPos = 5
	return statPos

func upgradeLife(hero):
	var positionOfClass
	
	match hero.charClass.name:
		CLASS_BOX:
			positionOfClass = 0
		CLASS_ARCHER:
			positionOfClass = 1
		CLASS_SWORD_MASTER:
			positionOfClass = 2
		CLASS_WIZARD:
			positionOfClass = 3
		CLASS_NINJA :
			positionOfClass = 4
	
	var primaryStatName = classes[positionOfClass].poweredStat[0]
	var primaryStatPos = _getStatPosByName(primaryStatName)
	
	return 100 + 5 * hero.stats[primaryStatPos].value + 2 * hero.stats[5].value

func getRandomClass():
	return classes[int(rand_range(0, classes.size()))]
	
func getInitialStatsByClass(classGiven):
	var positionOfClass
	
	match classGiven:
		CLASS_BOX:
			positionOfClass = 0
		CLASS_ARCHER:
			positionOfClass = 1
		CLASS_SWORD_MASTER:
			positionOfClass = 2
		CLASS_WIZARD:
			positionOfClass = 3
		CLASS_NINJA :
			positionOfClass = 4
	
	var cont = 0
	while(cont < classes[positionOfClass].poweredStat.size()):
		var actualStatToBoost = classes[positionOfClass].poweredStat[cont]
		
		var pointsToSplit = [ 1, 2, 3]
		var pointsToSplitSelected = pointsToSplit[int(rand_range(0, pointsToSplit.size()))]
		
		var cont2 = 0
		while(cont2 < stats.size()):
			if actualStatToBoost == stats[cont2].name:
				stats[cont2].value += pointsToSplitSelected
			
			cont2 +=1
		
		cont +=1
	return stats
