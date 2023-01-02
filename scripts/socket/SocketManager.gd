extends Node


var websocket_url = "ws://localhost:8025/server/1/YOLOGODOT"
var _client = WebSocketClient.new()

const CONNECTED = "connected"
const DISCONNECTED = "disconnected"
const CONNECTING = "connecting"
const NOT_REQUESTED = "connecting"

var state = NOT_REQUESTED

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

func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
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
	var data = _client.get_peer(1).get_packet().get_string_from_utf8()
	print("Got data from server: ", data)
	waitingRequests(data)

func _send(endpoint, data):
	var request = {
		"endpoint": endpoint,
		"content": data
	}
	var json = JSON.print(request)
	print("Sending: " + json)
	_client.get_peer(1).set_write_mode(WebSocketPeer.WRITE_MODE_TEXT)
	_client.get_peer(1).put_var(json)

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

func waitingRequests(response):
	var json = JSON.parse(response)
	var result
	
	if json.error != OK:
		print("error " + JSON.print(json.error))
		return
	else:
		result = json.result
	
	if INTENT_CONNECTING_ACTIVE == LOADING_STATE and result.endpoint == INTENT_CONNECTING:
		if result.content.code == INTENT_CORRECT:
			Session.playerId = result.from
			INTENT_CONNECTING_ACTIVE = SUCCESS_STATE
			print("ID obtenido del server: " + Session.playerId)
		else:
			INTENT_CONNECTING_ACTIVE = ERROR_STATE
	
	if INTENT_RE_CONNECTING_ACTIVE == LOADING_STATE and result.endpoint == INTENT_RE_CONNECTING:
		if result.content.code == INTENT_CORRECT:
			INTENT_RE_CONNECTING_ACTIVE = SUCCESS_STATE
			#TODO
		else:
			INTENT_RE_CONNECTING_ACTIVE = ERROR_STATE
		
	if INTENT_CREATE_ROOM_ACTIVE == LOADING_STATE and result.endpoint == INTENT_CREATE_ROOM:
		if result.content.code == INTENT_CORRECT:
			INTENT_CREATE_ROOM_ACTIVE = SUCCESS_STATE
			print("Room creada: " + Session.playerId)
		else:
			INTENT_CREATE_ROOM_ACTIVE = ERROR_STATE
		
	if INTENT_CLOSE_ROOM_ACTIVE == LOADING_STATE and result.endpoint == INTENT_CLOSE_ROOM:
		if result.content.code == INTENT_CORRECT:
			INTENT_CLOSE_ROOM_ACTIVE = SUCCESS_STATE
			#TODO
		else:
			INTENT_CLOSE_ROOM_ACTIVE = ERROR_STATE
		
	if INTENT_ABANDON_ROOM_ACTIVE == LOADING_STATE and result.endpoint == INTENT_ABANDON_ROOM:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.lastDisconnectedUser = result.content.data
			
			print("Last disconnected user: " + JSON.print(result.content.data))
			
			INTENT_ABANDON_ROOM_ACTIVE = NOT_REQUESTED_STATE
		else:
			INTENT_ABANDON_ROOM_ACTIVE = ERROR_STATE
		
	if INTENT_GET_ROOMS_ACTIVE == LOADING_STATE and result.endpoint == INTENT_GET_ROOMS:
		if result.content.code == INTENT_CORRECT:
			SocketRooms.rooms = result.content.data
			INTENT_GET_ROOMS_ACTIVE = SUCCESS_STATE
			print("Rooms obtenidas: " + str(SocketRooms.rooms.size()))
		else:
			INTENT_GET_ROOMS_ACTIVE = ERROR_STATE
		
	if INTENT_JOIN_ROOM_ACTIVE == LOADING_STATE and result.endpoint == INTENT_JOIN_ROOM:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.setData(result.content.data)
			INTENT_JOIN_ROOM_ACTIVE = SUCCESS_STATE
			print("Unido a la room: " + JSON.print(RoomInfo))
		else:
			INTENT_JOIN_ROOM_ACTIVE = ERROR_STATE
	
	if INTENT_USERS_INFO_ACTIVE == LOADING_STATE and result.endpoint == INTENT_USERS_INFO:
		if result.content.code == INTENT_CORRECT:
			RoomInfo.usersInfo = result.content.data
			
			print("Informacion de usuarios recibida: " + JSON.print(RoomInfo.usersInfo))
			INTENT_USERS_INFO_ACTIVE = SUCCESS_STATE
		else:
			INTENT_USERS_INFO_ACTIVE = ERROR_STATE
	
	if INTENT_UPLOAD_INFO_ACTIVE == LOADING_STATE and result.endpoint == INTENT_UPLOAD_INFO:
		if result.content.code == INTENT_CORRECT:
			INTENT_UPLOAD_INFO_ACTIVE = SUCCESS_STATE
		else:
			INTENT_UPLOAD_INFO_ACTIVE = ERROR_STATE

func createRoom(roomName, roomCode):
	INTENT_CREATE_ROOM_ACTIVE = LOADING_STATE
	_send(INTENT_CREATE_ROOM, {
		"id": Session.playerId,
		"name": roomName,
		"code": roomCode
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
	_send(INTENT_UPLOAD_INFO, {
		"playerInfo": {
			"name": Session.playerName,
			"playerId": Session.playerId
		}
	})

func getUsersInfo(users):
	INTENT_USERS_INFO_ACTIVE = LOADING_STATE
	_send(INTENT_USERS_INFO, {
		"userIds": users
	})


################################################
###
### End-Region Requests
###
################################################
