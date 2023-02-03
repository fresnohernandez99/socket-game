extends Node


var websocket_url
var _client = WebSocketClient.new()

const CONNECTED = "connected"
const DISCONNECTED = "disconnected"
const CONNECTING = "connecting"
const NOT_REQUESTED = "connecting"

const SET_IN_FIELD_PLAY = "set-in-field"
const OVER_PIECE_PLAY = "over-piece"

var state = NOT_REQUESTED

var actualRootNode = null
var toast: Toast

func _process(delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()

func startConnection():
	state = CONNECTING
	INTENT_CONNECTING_ACTIVE = LOADING_STATE
	# TODO get websocket url from persistense 
	#
	#
	#
	
	websocket_url = "ws://" + Persistence.data.option.ip + ":" + Persistence.data.option.port
	
	var err = _client.connect_to_url(websocket_url)
	
	if err != OK:
		print("Unable to connect")
		state = DISCONNECTED
	else:
		state = CONNECTED
		print(err)
	
	_connectManagers()

func _connectManagers():
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")
	_client.connect("server_close_request", self, "_server_close_request")

func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	#_showError("Disconnected: ")
	INTENT_CONNECTING_ACTIVE = ERROR_STATE
	state = DISCONNECTED

func _server_close_request(code: int = 0, reason: String = ""):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Code: ", code, " Reason: ", reason)
	INTENT_CONNECTING_ACTIVE = ERROR_STATE
	state = DISCONNECTED

func _connected(param):
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	#_client.get_peer(1).put_packet("Test packet".to_utf8())
	state = CONNECTED

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var peer = _client.get_peer(1)
	
	var data = peer.get_packet().get_string_from_utf8()
	
	var error = peer.get_packet_error()
	
	if error:
		print("Error: " + JSON.print(error))
	
	#print("Got data from server: ", data)
	waitingRequests(data)

func _send(endpoint, data):
	var request = {
		"endpoint": endpoint,
		"content": data
	}
	var json = JSON.print(request)
	#print("Sending: " + json)
	var peer = _client.get_peer(1)
	peer.set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	peer.put_packet(json.to_utf8())

func _plainSend(endpoint, request):
	#var json = JSON.print(request)
	#print("Sending: " + json)
	var peer = _client.get_peer(1)
	peer.set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	peer.put_packet(request.to_utf8())

func _showError(actualErrorMsg):
	toast = Toast.new(actualErrorMsg, Toast.LENGTH_SHORT)
	actualRootNode.add_child(toast)
	toast.show()
################################################
###
### Region Requests
###
################################################

const NOT_REQUESTED_STATE = 0
const LOADING_STATE = 1
const SUCCESS_STATE = 2
const ERROR_STATE = 3

const INTENT_WITH_ERROR = "0"
const INTENT_CORRECT = "200"

var INTENT_CONNECTING_ACTIVE = NOT_REQUESTED_STATE
const INTENT_CONNECTING = "1"

var INTENT_RE_CONNECTING_ACTIVE = NOT_REQUESTED_STATE
const INTENT_RE_CONNECTING = "2"

var INTENT_CREATE_ROOM_ACTIVE = NOT_REQUESTED_STATE
const INTENT_CREATE_ROOM = "3"

var INTENT_CLOSE_ROOM_ACTIVE = NOT_REQUESTED_STATE
const INTENT_CLOSE_ROOM = "4"

var INTENT_ABANDON_ROOM_ACTIVE = NOT_REQUESTED_STATE
const INTENT_ABANDON_ROOM = "5"

var INTENT_GET_ROOMS_ACTIVE = NOT_REQUESTED_STATE
const INTENT_GET_ROOMS = "6"

var INTENT_JOIN_ROOM_ACTIVE = NOT_REQUESTED_STATE
const INTENT_JOIN_ROOM = "7"

var INTENT_USERS_INFO_ACTIVE = NOT_REQUESTED_STATE
const INTENT_USERS_INFO = "8"

var INTENT_UPLOAD_INFO_ACTIVE = NOT_REQUESTED_STATE
const INTENT_UPLOAD_INFO = "9"

var INTENT_GET_CONFIGURATIONS_ACTIVE = NOT_REQUESTED_STATE
const INTENT_GET_CONFIGURATIONS = "10"

var INTENT_UPDATE_CONFIGURATIONS_ACTIVE = NOT_REQUESTED_STATE
const INTENT_UPDATE_CONFIGURATIONS = "11"

var INTENT_SEND_PLAYS_ACTIVE = NOT_REQUESTED_STATE
const INTENT_SEND_PLAYS = "12"

var INTENT_ROUND_RESULTS_ACTIVE = NOT_REQUESTED_STATE
const INTENT_ROUND_RESULTS = "13"

func waitingRequests(response):
	var json = JSON.parse(response)
	var result
	
	if json.error != OK:
		_showError("Error on: parsing")
		return
	else:
		result = json.result
	
	if INTENT_CONNECTING_ACTIVE == LOADING_STATE and result.endpoint == INTENT_CONNECTING:
		if result.content.code == INTENT_CORRECT:
			Session.playerId = result.from
			INTENT_CONNECTING_ACTIVE = SUCCESS_STATE
			Persistence.data.hero.playerId = Session.playerId
			print("ID obtenido del server: " + Session.playerId)
		else:
			_showError("Error on: " + INTENT_CONNECTING)
			INTENT_CONNECTING_ACTIVE = ERROR_STATE
	
	if INTENT_RE_CONNECTING_ACTIVE == LOADING_STATE and result.endpoint == INTENT_RE_CONNECTING:
		if result.content.code == INTENT_CORRECT:
			INTENT_RE_CONNECTING_ACTIVE = SUCCESS_STATE
			#TODO
		else:
			_showError("Error on: " + INTENT_RE_CONNECTING)
			INTENT_RE_CONNECTING_ACTIVE = ERROR_STATE
		
	if INTENT_CREATE_ROOM_ACTIVE == LOADING_STATE and result.endpoint == INTENT_CREATE_ROOM:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.setData(result.content.data.room, result.content.data.spaceConfiguration)
			
			INTENT_CREATE_ROOM_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_CREATE_ROOM)
			INTENT_CREATE_ROOM_ACTIVE = ERROR_STATE
		
	if result.endpoint == INTENT_CLOSE_ROOM:
		if result.content.code == INTENT_CORRECT:
			INTENT_CLOSE_ROOM_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_CLOSE_ROOM)
			INTENT_CLOSE_ROOM_ACTIVE = ERROR_STATE
		
	if result.endpoint == INTENT_ABANDON_ROOM and RoomInfo.id == result.content.data.roomId:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.lastDisconnectedUser = result.content.data.playerId
			
			INTENT_ABANDON_ROOM_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_ABANDON_ROOM)
			INTENT_ABANDON_ROOM_ACTIVE = ERROR_STATE
		
	if INTENT_GET_ROOMS_ACTIVE == LOADING_STATE and result.endpoint == INTENT_GET_ROOMS:
		if result.content.code == INTENT_CORRECT:
			SocketRooms.roomsWithConfigs = result.content.data.rooms
			
			INTENT_GET_ROOMS_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_GET_ROOMS)
			INTENT_GET_ROOMS_ACTIVE = ERROR_STATE
		
	if result.endpoint == INTENT_JOIN_ROOM:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.setData(result.content.data.room, result.content.data.spaceConfiguration)
			
			INTENT_JOIN_ROOM_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_JOIN_ROOM)
			INTENT_JOIN_ROOM_ACTIVE = ERROR_STATE
	
	if INTENT_USERS_INFO_ACTIVE == LOADING_STATE and result.endpoint == INTENT_USERS_INFO:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.usersInfo = result.content.data
			
			INTENT_USERS_INFO_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_USERS_INFO)
			INTENT_USERS_INFO_ACTIVE = ERROR_STATE
	
	if INTENT_UPLOAD_INFO_ACTIVE == LOADING_STATE and result.endpoint == INTENT_UPLOAD_INFO:
		if result.content.code == INTENT_CORRECT:
			
			INTENT_UPLOAD_INFO_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_UPLOAD_INFO)
			INTENT_UPLOAD_INFO_ACTIVE = ERROR_STATE
	
	if INTENT_GET_CONFIGURATIONS_ACTIVE == LOADING_STATE and result.endpoint == INTENT_GET_CONFIGURATIONS:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.configuration = result.content.data
			
			INTENT_GET_CONFIGURATIONS_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_GET_CONFIGURATIONS)
			INTENT_GET_CONFIGURATIONS_ACTIVE = ERROR_STATE
	
	if INTENT_UPDATE_CONFIGURATIONS_ACTIVE == LOADING_STATE and result.endpoint == INTENT_UPDATE_CONFIGURATIONS:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.configuration = result.content.data
			
			INTENT_UPDATE_CONFIGURATIONS_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_UPDATE_CONFIGURATIONS)
			INTENT_UPDATE_CONFIGURATIONS_ACTIVE = ERROR_STATE
	
	if result.endpoint == INTENT_SEND_PLAYS:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.lastPlayerReady = result.content.data.playerFrom
			
			INTENT_SEND_PLAYS_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_SEND_PLAYS)
			INTENT_SEND_PLAYS_ACTIVE = ERROR_STATE
	
	if result.endpoint == INTENT_ROUND_RESULTS:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.roundResult = result.content.data
			
			RoomInfo.allPlayersReady = true
			
			INTENT_ROUND_RESULTS_ACTIVE = SUCCESS_STATE
		else:
			_showError("Error on: " + INTENT_ROUND_RESULTS)
			INTENT_ROUND_RESULTS_ACTIVE = ERROR_STATE

func createRoom(roomName, roomCode):
	INTENT_CREATE_ROOM_ACTIVE = LOADING_STATE
	_send(INTENT_CREATE_ROOM, {
		"room": {
			"id": Session.playerId,
			"name": roomName,
			"code": roomCode
		},
		"spaceConfiguration": {
			"gameBase": "01",
			"defeatCause": 3,
			"maxPlayers": 2,
			"minPlayers": 2,
			"evaluateMiss": true,
			"evaluateSpeed": true
		}
	})

func loadRooms():
	INTENT_GET_ROOMS_ACTIVE = LOADING_STATE
	
	_send(INTENT_GET_ROOMS, {})

func abandonRoom():
	INTENT_ABANDON_ROOM_ACTIVE = LOADING_STATE
	_send(INTENT_ABANDON_ROOM, {
		"hostId": Session.playerId,
		"roomId": RoomInfo.id
	})

func joinRoom(roomId, code):
	INTENT_JOIN_ROOM_ACTIVE = LOADING_STATE
	_send(INTENT_JOIN_ROOM, {
		"roomId": roomId,
		"code": code,
	})

func uploadInfo():
	INTENT_UPLOAD_INFO_ACTIVE = LOADING_STATE
	Persistence.data.hero.name = Session.playerName
	
	_send(INTENT_UPLOAD_INFO, {
		"playerInfo": {
			"name": Session.playerName,
			"playerId": Session.playerId,
			"handDeck": {
				"name": "hand-deck",
				"items": [Persistence.data.hero]
			}
		}
	})

func getUsersInfo(users):
	INTENT_USERS_INFO_ACTIVE = LOADING_STATE
	_send(INTENT_USERS_INFO, {
		"userIds": users
	})

func closeRoomAndStart():
	_send(INTENT_CLOSE_ROOM, {
		"roomId": RoomInfo.id
	})

func updateRoomConfigs():
	INTENT_UPDATE_CONFIGURATIONS_ACTIVE = LOADING_STATE
	_send(INTENT_UPDATE_CONFIGURATIONS, {
		"roomId": RoomInfo.id,
		"spaceConfiguration": {
			"gameBase": "01",
			"defeatCause": 3,
			"maxPlayers": 2,
			"minPlayers": 2,
			"evaluateMiss": true,
			"evaluateSpeed": true
		}
	})

func sendInitPlay():
	INTENT_SEND_PLAYS_ACTIVE = LOADING_STATE
	_send(INTENT_SEND_PLAYS, {
		"roomId": RoomInfo.id,
		"plays": [
			{
				"playerId": Session.playerId,
				"type": SET_IN_FIELD_PLAY,
				"piece": Persistence.data.hero,
				"newPosition": Session.playerId + "_1"
			}
		]
	})

func sendOverPiecePlay(move, posTo, posFrom):
	INTENT_SEND_PLAYS_ACTIVE = LOADING_STATE
	
	var toSend = {
		"roomId": RoomInfo.id,
		"plays": [
			{
				"playerId": Session.playerId,
				"type": OVER_PIECE_PLAY,
				"positionFrom": posFrom,
				"positionTo": posTo,
				"move": move,
				"wasMiss": false
			}
		]
	}
	_send(INTENT_SEND_PLAYS, toSend)

################################################
###
### End-Region Requests
###
################################################
