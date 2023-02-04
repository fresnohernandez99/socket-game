extends Node

func _ready():
	randomize()

func evaluateProbability():
	pass

static func sort(a, b):
	if a.stats[4].value > b.stats[0].value:
		return true
	return false

func calculatePlaysResult(gameEngine, pA: Array):
	if gameEngine.getConfigurations().evaluateSpeed == true:
		var allOfSet = true
		for i in pA:
			if i.type == "over-piece":
				allOfSet = false
		
		if !allOfSet:
			for i in range(pA.size()-1, -1, -1):
				for j in range(1,i+1,1):
					var aux1 = gameEngine.findInGrid(pA[j-1].positionFrom).stats[4].value
					var aux1O = pA[j-1]
					var aux2 = gameEngine.findInGrid(pA[j].positionFrom).stats[4].value
					var aux2O = pA[j]
					
					if aux1 < aux2:
						var temp = aux1O
						pA[j-1] = aux2O
						pA[j] = temp
	
	var playResult = []
	
	for it in pA:
		match(it.type):
			"set-in-field":
				playResult.push_back(setInField(gameEngine, it))
			"over-piece":
				playResult.push_back(overPiecePlay(gameEngine, it))
	return playResult

func setInField(gameEngine, play):
	if _overSizedField(gameEngine):
		pass
	 
	if (play.piece.position != null or play.piece.position != "") and play.piece.position != play.newPosition:
		gameEngine.removeInGrid(play.piece.position)
	
	play.piece.position = play.newPosition
	gameEngine.getSpaceGrid().grid.push_back(play.piece)
	
	return play

func _overSizedField(gameEngine):
	return gameEngine.totalInSpace < gameEngine.getConfigurations().fieldSize


func overPiecePlay(gameEngine, play):
	var piece = gameEngine.findInGrid(play.positionTo)
	
	if play.move.type == "attack" and gameEngine.getConfigurations().evaluateMiss == true:
		var r = rand_range(0, 100)
		var isMiss = r <= piece.stats[1].value
		
		play.wasMiss = isMiss
	
	return play






