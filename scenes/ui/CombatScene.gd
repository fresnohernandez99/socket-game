extends Node

const MoveHandler = preload("res://scripts/engine/MoveHandler.gd")
const MoveNames = preload("res://scripts/engine/MoveNames.gd")

var pieces = [Persistence.data.hero]
var hero = pieces.duplicate(true)[0]

var moveNames = MoveNames.new()
var moveHandler = MoveHandler.new()

signal ShowMsg(playMsg)
signal IsLoading(state)

onready var players = []
var matchEnded = false

onready var music = $AudioStreamPlayer2D

onready var combatControls = $CombatControls

onready var playerContainer = $PlayerContainer

onready var playerPosition = $PlayerContainer/Player
onready var enemy1Position = $PlayerContainer/Enemy1

onready var enemiesPosition = [enemy1Position] 

func _ready():
	music.volume_db = int(Persistence.data.option.volume / 10)
	emit_signal("IsLoading", [true])
	emit_signal("ShowMsg", ["La batalla va a comenzar"])
	SocketManager.sendInitPlay()


func _process(delta):
	if SocketManager.INTENT_SEND_PLAYS_ACTIVE == SocketManager.SUCCESS_STATE:
		SocketManager.INTENT_SEND_PLAYS_ACTIVE = SocketManager.NOT_REQUESTED_STATE
		setPlayerReady()
	
	if SocketManager.INTENT_ROUND_RESULTS_ACTIVE == SocketManager.SUCCESS_STATE:
		SocketManager.INTENT_ROUND_RESULTS_ACTIVE = SocketManager.NOT_REQUESTED_STATE
		_initNextPlay()

#################################################
# Visual actions region
#################################################
func setPlayerReady():
	for player in players:
		if player.hero.playerId == RoomInfo.lastPlayerReady:
			player.setReady()
			RoomInfo.lastPlayerReady = ""
			
			if Session.playerId == RoomInfo.lastPlayerReady:
				emit_signal("IsLoading", [true])
				emit_signal("ShowMsg", ["Listos!"])

func _initNextPlay():
	combatControls.setUnaviable(false)
	emit_signal("IsLoading", [false])
	
	for p in players:
		p.setThinking()
	
	if RoomInfo.roundResult.size() > 0:
		var actualPlay = RoomInfo.roundResult.pop_front()
		
		match(actualPlay.type):
			SocketManager.SET_IN_FIELD_PLAY:
				_setInFieldPlay(actualPlay)
			SocketManager.OVER_PIECE_PLAY:
				_setPlayOverHero(actualPlay)

func _setInFieldPlay(actualPlay):
	var Player = load("res://scenes/ui/Player.tscn")
	var playerIns = Player.instance()
	
	# poner heroe del jugador en posicion izquierda
	if actualPlay.playerId == Session.playerId:
		playerIns.setData(actualPlay.piece, playerPosition.global_position.x,  playerPosition.global_position.y, playerIns.LEFT)
		
		hero.position = actualPlay.piece.position
		
		combatControls.setHero(hero)
		
		emit_signal("ShowMsg", ["[color=blue]Has[/color] entrado en combate!"])
	else:
		var nextPlayerPosition
		if players.size() > 0:
			nextPlayerPosition = enemiesPosition[players.size() - 1]
		else:
			nextPlayerPosition = enemiesPosition[0]
		playerIns.setData(actualPlay.piece, nextPlayerPosition.global_position.x,  nextPlayerPosition.global_position.y)
		emit_signal("ShowMsg", ["[color=red]"+ actualPlay.piece.name +"[/color] ha entrado en combate!"])
		
		combatControls.addEnemyPlayer(actualPlay.piece)
		
	playerContainer.add_child(playerIns)
	players.push_back(playerIns)

func _setPlayOverHero(actualPlay):
	var playerFrom
	var playerTo
	
	for player in players:
		if player.hero.position == actualPlay.positionFrom:
			playerFrom = player
		if player.hero.position == actualPlay.positionTo:
			playerTo = player
	
	var moveName = moveNames.getMoveName(playerFrom.hero.charClass.name, actualPlay.move.id)
	
	var colorFrom = "green"
	var colorTo = "red"
	
	var moveColor = "aqua"
	var missColor = "yellow"
	
	if playerFrom.hero.id == hero.id:
		colorFrom = "green"
	else:
		colorFrom = "red"
	
	if playerTo.hero.id == hero.id:
		colorTo = "green"
	else:
		colorTo = "red"
	
	if actualPlay.wasMiss:
		emit_signal("ShowMsg", ["[color="+ colorFrom + "]"+ playerFrom.hero.name +"[/color] ha usado " + "[color="+ moveColor + "]" + moveName + "[/color] y ha [color="+ missColor + "]fallado[/color]!" ])
	else:
		_showAnimationOver(actualPlay.move, playerTo)
		_showAnimationFrom(actualPlay.move, playerFrom)
		
		if playerTo.hero.id == playerFrom.hero.id:
			emit_signal("ShowMsg", ["[color="+ colorFrom + "]"+ playerFrom.hero.name +"[/color] ha usado " + "[color="+ moveColor + "]" + moveName + "[/color]!" ])
		else:
			emit_signal("ShowMsg", ["[color="+ colorFrom + "]"+ playerFrom.hero.name +"[/color] ha usado " + "[color="+ moveColor + "]" + moveName + "[/color] contra " + "[color="+ colorTo + "]" + playerTo.hero.name +"[/color]!" ])
	
	_calculatePlaysResults(actualPlay)

func _showAnimationOver(move, player):
	# TODO
	pass

func _showAnimationFrom(move, player):
	# TODO
	pass

func _on_CombatControls_showNextPlay():
	_initNextPlay()

#################################################
# Socket actions region
#################################################
func _sendPlay(move, posTo):
	SocketManager.sendOverPiecePlay(move, posTo, hero.position)

func _on_CombatControls_UseMove(move):
	_sendPlay(move[0], move[1])
	combatControls.setUnaviable(true)

#################################################
# Calculate region
#################################################
func _calculatePlaysResults(actualPlay):
	if !matchEnded:
		var playerFrom
		var playerTo
		
		for player in players:
			if player.hero.position == actualPlay.positionFrom:
				playerFrom = player
			if player.hero.position == actualPlay.positionTo:
				playerTo = player
				
		if actualPlay.wasMiss:
			playerFrom.miss()
			return
		
		match(actualPlay.move.type):
			moveHandler.ATTACK_MOVE:
				_calculateAttack(actualPlay.move, playerTo, playerFrom)
			moveHandler.DEFENSE_MOVE:
				var increase = playerTo.hero.stats[0].value * actualPlay.move.percent
				playerTo.hero.stats[0].value += increase
				playerTo.increaseStat(increase)
			moveHandler.HEAL_MOVE:
				if playerTo.hero.lifePointsLose > actualPlay.move.restoredPoints:
					playerTo.hero.lifePointsLose -= actualPlay.move.restoredPoints
				else:
					playerTo.hero.lifePointsLose = 0
				playerTo.increaseLife(actualPlay.move.restoredPoints)
			moveHandler.BOOST_MOVE:
				playerTo.hero.stats[actualPlay.move.attrToBoost].value += actualPlay.move.value
				playerTo.increaseStat(actualPlay.move.value)
			moveHandler.INSTANT_HEAL_MOVE:
				playerTo.hero.lifePointsLose = 0
				playerTo.increaseLife("∞")

		if playerFrom.hero.id == hero.id:
			combatControls.setHero(playerFrom.hero)
		

func _calculateAttack(move, playerTo, playerFrom):
	var damage = move.damage
	var types = move.types
	
	for t in types:
		match(t):
			moveHandler.ATTACK_TYPE_MELEE:
				var stregth = playerFrom.hero.stats[5].value
				var percent = damage * stregth / 100
				
				damage += percent
				
			moveHandler.ATTACK_TYPE_WEAPON:
				var stregth = playerFrom.hero.stats[5].value
				var percent1 = damage * stregth / 100
				
				var intellect = playerFrom.hero.stats[2].value
				var percent2 = damage * intellect / 100
				
				damage += percent1
				damage += percent2
				
			moveHandler.ATTACK_TYPE_MAGIC:
				var magic = playerFrom.hero.stats[3].value
				var percent1 = damage * magic / 100
				
				var intellect = playerFrom.hero.stats[2].value
				var percent2 = damage * intellect / 100
				
				damage += percent1
				damage += percent2
	
	var defenseAgainst = playerTo.hero.stats[0].value
	
	damage -= int(damage * defenseAgainst / 100)
	
	playerTo.hero.lifePointsLose += damage
	
	playerTo.receiveHit(damage)
	
	matchEnded = _calculateActualMatch()

func _calculateActualMatch():
	var loserCount = 0
	
	for p in players:
		if p.hero.lifePointsLose > p.hero.lifePoints:
			p.lose()
			loserCount += 1
	
	if loserCount == players.size() - 1:
		endMatch()
		return true
	return false

func endMatch():
	yield(get_tree().create_timer(4), "timeout")
	RoomInfo.finalResult = [players[0].hero, players[1].hero]
	get_tree().change_scene("res://scenes/ui/EndCombatScene.tscn")









