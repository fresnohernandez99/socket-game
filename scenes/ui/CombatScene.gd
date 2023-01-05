extends Node


signal ShowMsg(playMsg)
signal IsLoading(state)

onready var Player = preload("res://scenes/ui/Player.tscn")
onready var players = []

onready var playerContainer = $PlayerContainer

onready var playerPosition = $PlayerContainer/Player
onready var enemy1Position = $PlayerContainer/Enemy1

onready var enemiesPosition = [enemy1Position] 

func _ready():
	emit_signal("IsLoading", [true])
	emit_signal("ShowMsg", ["The battle is about to start"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
			RoomInfo.lastPlayersReady = ""
			
			if Session.playerId == RoomInfo.lastPlayerReady:
				emit_signal("IsLoading", [true])
				emit_signal("ShowMsg", ["READY!"])


func _initNextPlay():
	if RoomInfo.roundResult.size() > 0:
		var actualPlay = RoomInfo.roundResult.pop_front()
		
		match(actualPlay.type):
			SocketManager.SET_IN_FIELD_PLAY:
				_setInFieldPlay(actualPlay)
			SocketManager.OVER_PIECE_PLAY:
				pass

func _setInFieldPlay(actualPlay):
	var playerIns = Player.instance()
	
	# poner heroe del jugador en posicion izquierda
	if actualPlay.playerId == Session.playerId:
		playerIns.setData(actualPlay.piece, playerPosition.global_position.x,  playerPosition.global_position.y, playerIns.LEFT)
		
	else:
		var nextPlayerPosition
		if players.size() > 0:
			nextPlayerPosition = enemiesPosition[players.size() - 1]
		else:
			nextPlayerPosition = enemiesPosition[0]
		
		playerIns.setData(actualPlay.piece, nextPlayerPosition.global_position.x,  nextPlayerPosition.global_position.y)
	
	playerContainer.add_child(playerIns)
	players.push_back(playerIns)
	
func _onReproducePlayComplete():
	pass


func _on_CombatControls_showNextPlay():
	_initNextPlay()

#################################################
# Socket actions region
#################################################
func _sendAction():
	pass

func _onActionsReceived():
	pass

func _calculateResults():
	pass

#################################################
# Status actions region
#################################################
















