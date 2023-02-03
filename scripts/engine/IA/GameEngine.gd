extends Node

var HeroBaseCalculator = load("res://scripts/engine/IA/HeroBaseCalculator.gd").new()

var terrain
var wasBattleInitialized = false
var actualPlaysList = []
var playBy = 0
var totalInSpace = 0

func removeInGrid(position):
	var index = findIndexInGrid(position)
	if index != -1:
		getSpaceGrid().grid.remove(index)

func findInGrid(position):
	for p in getSpaceGrid().grid:
		if p.position == position:
			return p
	return null

func findIndexInGrid(position):
	var piece
	var cont = 0
	var index = -1
	for p in getSpaceGrid().grid:
		if p .position == position:
			piece = p
			index = cont
		cont += 1
	
	return index


func initConfigurations(t):
	self.terrain = t
	return self.terrain

func getConfigurations():
	return self.terrain.space.configuration
	
func getTerrain():
	return self.terrain

func getSpaceGrid():
	return self.terrain.spaceGrid

func getPlayers():
	return self.terrain.playerList

func getPlayersCount():
	return getPlayers().size()

func setConfigurations(configs):
	terrain.space.configuration = configs

func addPlayers(playerList):
	if !wasBattleInitialized:
		self.terrain.playerList = playerList

func addPlays(list):
	for i in list:
		actualPlaysList.push_back(i)
	playBy +=1
	
	return playBy

func getPlaysForCalculate():
	return actualPlaysList

func cleanPlays():
	actualPlaysList = []
	playBy = 0

##################################################
#
# Initial methods for simple game
#
#################################################

func calculatePlaysResult(playersPlays):
	match(getConfigurations().gameBase):
		"01":
			return HeroBaseCalculator.calculatePlaysResult(self, playersPlays)















