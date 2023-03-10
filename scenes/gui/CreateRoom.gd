extends Node

onready var nameTextEdit = $Control/VBoxContainer/NameTextEdit
onready var roomCodeTextEdit = $Control/VBoxContainer/RoomCodeTextEdit
onready var creatingDialog = $Control/CreatingDialog

func _ready():
	SocketManager.actualRootNode = get_node("/root")

func _process(delta):
	if SocketManager.INTENT_CREATE_ROOM_ACTIVE == SocketManager.SUCCESS_STATE:
		SocketManager.INTENT_CREATE_ROOM_ACTIVE = SocketManager.NOT_REQUESTED_STATE
		#updateRoomConfigurations()
		onCreateRoom()
	
	#if SocketManager.INTENT_UPDATE_CONFIGURATIONS_ACTIVE == SocketManager.SUCCESS_STATE:
	#	SocketManager.INTENT_UPDATE_CONFIGURATIONS_ACTIVE = SocketManager.NOT_REQUESTED_STATE
	#	onCreateRoom()
	
func callCreateRoom():
	var roomName = nameTextEdit.text
	var roomCode = roomCodeTextEdit.text
	
	if roomName.length() == 0:
		var toast = Toast.new("Fill all please", Toast.LENGTH_SHORT)
		get_node("/root").add_child(toast)
		toast.show()
	else:
		RoomInfo.id = Session.playerId
		RoomInfo.roomName = roomName
		RoomInfo.code = roomCode
		SocketManager.createRoom(roomName, roomCode)
		creatingDialog.show()

func updateRoomConfigurations():
	SocketManager.updateRoomConfigs()

func onCreateRoom():
	get_tree().change_scene("res://scenes/gui/WaitingLobby.tscn")


func _on_CreateRoomBtn_pressed():
	callCreateRoom()


func _on_CancelBtn_pressed():
	get_tree().change_scene("res://scenes/gui/RoomList.tscn")

