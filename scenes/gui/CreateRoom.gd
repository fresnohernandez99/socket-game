extends Node

onready var nameTextEdit = $Control/VBoxContainer/NameTextEdit
onready var roomCodeTextEdit = $Control/VBoxContainer/RoomCodeTextEdit
onready var errorDialog = $Control/ErrorDialog


func _process(delta):
	if SocketManager.INTENT_CREATE_ROOM_ACTIVE == SocketManager.SUCCESS_STATE:
		onCreateRoom()


func callCreateRoom():
	var roomName = nameTextEdit.text
	var roomCode = roomCodeTextEdit.text
	
	if roomName.length() == 0 or roomCode.length() == 0:
		errorDialog.show()
	else:
		RoomInfo.id = Session.playerId
		RoomInfo.roomName = roomName
		RoomInfo.code = roomCode
		SocketManager.createRoom(roomName, roomCode)

func onCreateRoom():
	SocketManager.INTENT_CREATE_ROOM_ACTIVE = SocketManager.NOT_REQUESTED_STATE
	


func _on_CreateRoomBtn_pressed():
	callCreateRoom()
