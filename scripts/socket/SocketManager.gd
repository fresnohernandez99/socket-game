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

func _connected():
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

var INTENT_CANCEL_ROOM_ACTIVE = NOT_REQUESTED_STATE
const INTENT_CANCEL_ROOM = "5"

var INTENT_GET_ROOMS_ACTIVE = NOT_REQUESTED_STATE
const INTENT_GET_ROOMS = "6"

var INTENT_JOIN_ROOM_ACTIVE = NOT_REQUESTED_STATE
const INTENT_JOIN_ROOM = "7"

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
	
	if INTENT_RE_CONNECTING_ACTIVE:
		pass
		
	if INTENT_CREATE_ROOM_ACTIVE:
		pass
		
	if INTENT_CLOSE_ROOM_ACTIVE:
		pass
		
	if INTENT_CANCEL_ROOM_ACTIVE:
		pass
		
	if INTENT_GET_ROOMS_ACTIVE:
		pass
		
	if INTENT_JOIN_ROOM_ACTIVE:
		pass
	
################################################
###
### End-Region Requests
###
################################################
