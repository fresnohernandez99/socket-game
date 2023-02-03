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

onready var combatControls = $CombatControls

onready var playerContainer = $PlayerContainer

onready var playerPosition = $PlayerContainer/Player
onready var enemy1Position = $PlayerContainer/Enemy1

onready var enemiesPosition = [enemy1Position] 

func _ready():
	emit_signal("IsLoading", [true])
	emit_signal("ShowMsg", ["The battle is about to start"])
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
				emit_signal("ShowMsg", ["READY!"])

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
	print(actualPlay)
	var Player = load("res://scenes/ui/Player.tscn")
	var playerIns = Player.instance()
	
	# poner heroe del jugador en posicion izquierda
	if actualPlay.playerId == Session.playerId:
		playerIns.setData(actualPlay.piece, playerPosition.global_position.x,  playerPosition.global_position.y, playerIns.LEFT)
		
		hero.position = actualPlay.piece.position
		
		combatControls.setHero(hero)
		
		emit_signal("ShowMsg", ["[color=blue]You[/color] have entered in combat!"])
	else:
		var nextPlayerPosition
		if players.size() > 0:
			nextPlayerPosition = enemiesPosition[players.size() - 1]
		else:
			nextPlayerPosition = enemiesPosition[0]
		playerIns.setData(actualPlay.piece, nextPlayerPosition.global_position.x,  nextPlayerPosition.global_position.y)
		emit_signal("ShowMsg", ["[color=red]"+ actualPlay.piece.name +"[/color] has entered in combat!"])
		
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
		emit_signal("ShowMsg", ["[color="+ colorFrom + "]"+ playerFrom.hero.name +"[/color] has use " + "[color="+ moveColor + "]" + moveName + "[/color] and he [color="+ missColor + "]miss it[/color]!" ])
	else:
		_showAnimationOver(actualPlay.move, playerTo)
		_showAnimationFrom(actualPlay.move, playerFrom)
		
		if playerTo.hero.id == playerFrom.hero.id:
			emit_signal("ShowMsg", ["[color="+ colorFrom + "]"+ playerFrom.hero.name +"[/color] has use " + "[color="+ moveColor + "]" + moveName + "[/color]!" ])
		else:
			emit_signal("ShowMsg", ["[color="+ colorFrom + "]"+ playerFrom.hero.name +"[/color] has use " + "[color="+ moveColor + "]" + moveName + "[/color] over " + "[color="+ colorTo + "]" + playerTo.hero.name +"[/color]!" ])
	
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
			playerTo.hero.stats[0].value += playerTo.hero.stats[0].value * actualPlay.move.percent
		moveHandler.HEAL_MOVE:
			if playerTo.hero.lifePointsLose > actualPlay.move.restoredPoints:
				playerTo.hero.lifePointsLose -= actualPlay.move.restoredPoints
			else:
				playerTo.hero.lifePointsLose = 0
				
		moveHandler.BOOST_MOVE:
			playerTo.hero.stats[actualPlay.move.attrToBoost].value += actualPlay.move.value
		moveHandler.INSTANT_HEAL_MOVE:
			playerTo.hero.lifePointsLose = 0

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
	
	_calculateActualMatch()

func _calculateActualMatch():
	var loserCount = 0
	
	for p in players:
		if p.hero.lifePointsLose > p.hero.lifePoints:
			p.lose()
			loserCount += 1
	
	if loserCount == players.size() - 1:
		endMatch()

func endMatch():
	yield(get_tree().create_timer(4), "timeout")
	RoomInfo.finalResult = players
	get_tree().change_scene("res://scenes/ui/EndCombatScene.tscn")









