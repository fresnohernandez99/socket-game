extends Node


var isOwner = false

onready var listContainer = $Control/ScrollContainer/VBoxContainer

var playerItem = load("res://scenes/gui/PlayerItem.tscn")

func _ready():
	if Session.playerId == RoomInfo.roomOwner:
		isOwner = true
	
	getUsersInfo()

func _process(delta):
	if SocketManager.INTENT_USERS_INFO_ACTIVE == SocketManager.SUCCESS_STATE:
		onUsersInfoReceived()
	
	if SocketManager.INTENT_JOIN_ROOM_ACTIVE == SocketManager.SUCCESS_STATE:
		SocketManager.INTENT_JOIN_ROOM_ACTIVE = SocketManager.NOT_REQUESTED_STATE
		getUsersInfo()
	
	if SocketManager.INTENT_ABANDON_ROOM_ACTIVE == SocketManager.SUCCESS_STATE:
		SocketManager.INTENT_ABANDON_ROOM_ACTIVE = SocketManager.NOT_REQUESTED_STATE
		onUserAbandonLobby()
	
	if SocketManager.INTENT_CLOSE_ROOM_ACTIVE == SocketManager.SUCCESS_STATE:
		SocketManager.INTENT_CLOSE_ROOM_ACTIVE = SocketManager.NOT_REQUESTED_STATE

func getUsersInfo():
	SocketManager.getUsersInfo(RoomInfo.users)

func onUsersInfoReceived():
	SocketManager.INTENT_USERS_INFO_ACTIVE = SocketManager.NOT_REQUESTED_STATE
	
	var contR = listContainer.get_child_count() - 1
	while(contR >= 0):
		var theChild = listContainer.get_child(contR)
		listContainer.remove_child(theChild)
		contR -= 1
	
	var cont = 0
	while(cont < RoomInfo.usersInfo.size()):
		var ins = playerItem.instance()
		ins.setData(RoomInfo.usersInfo[cont], isOwner)
		
		listContainer.add_child(ins)
		cont += 1
	
func onUserAbandonLobby():
	if RoomInfo.roomOwner == RoomInfo.lastDisconnectedUser:
		get_tree().change_scene("res://scenes/gui/RoomList.tscn")
		return
	
	var cont = 0
	var indexFound = -1
	
	while(cont < RoomInfo.users.size()):
		var actualUser = RoomInfo.users[cont]
		if actualUser == RoomInfo.lastDisconnectedUser:
			indexFound = cont
		cont += 1
	
	RoomInfo.users.remove(indexFound)
	
	cont = 0
	indexFound = -1
	
	while(cont < RoomInfo.usersInfo.size()):
		var actualUser = RoomInfo.usersInfo[cont]
		if actualUser.playerId == RoomInfo.lastDisconnectedUser:
			indexFound = cont
		cont += 1
	
	RoomInfo.usersInfo.remove(indexFound)
	
	RoomInfo.lastDisconnectedUser = ""
	
	getUsersInfo()
	
	SocketManager.INTENT_ABANDON_ROOM_ACTIVE = SocketManager.NOT_REQUESTED_STATE

func _on_CancelBtn_pressed():
	SocketManager.abandonRoom()
	
	get_tree().change_scene("res://scenes/gui/RoomList.tscn")


func _on_StartBtn_pressed():
	if RoomInfo.configuration.minPlayers <= RoomInfo.usersInfo.size():
		SocketManager.closeRoomAndStart()
	else:
		var toast = Toast.new("Toast text", Toast.LENGTH_SHORT)
		get_node("/root").add_child(toast)
		toast.show()
