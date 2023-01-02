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


func getUsersInfo():
	SocketManager.getUsersInfo(RoomInfo.users)

func onUsersInfoReceived():
	SocketManager.INTENT_USERS_INFO_ACTIVE = SocketManager.NOT_REQUESTED_STATE
	
	var contR = 0
	while(contR < listContainer.get_child_count()):
		var theChild = listContainer.get_child(contR)
		listContainer.remove_child(theChild)
		contR += 1
	
	var cont = 0
	while(cont < RoomInfo.usersInfo.size()):
		var ins = playerItem.instance()
		ins.setData(RoomInfo.usersInfo[cont], isOwner)
		
		listContainer.add_child(ins)
		cont += 1
	
func onUserAbandonLobby():
	var cont = 0
	var indexFound = -1
	
	while(cont < RoomInfo.users.size()):
		var actualUser = RoomInfo.users[cont]
		if actualUser.id == RoomInfo.lastDisconnectedUser:
			indexFound = cont
		cont += 1
	
	RoomInfo.users.remove(indexFound)
	
	cont = 0
	indexFound = -1
	
	while(cont < RoomInfo.usersInfo.size()):
		var actualUser = RoomInfo.usersInfo[cont]
		if actualUser.id == RoomInfo.lastDisconnectedUser:
			indexFound = cont
		cont += 1
	
	RoomInfo.usersInfo.remove(indexFound)
	
	RoomInfo.lastDisconnectedUser = ""
	
	getUsersInfo()

func _on_CancelBtn_pressed():
	SocketManager.abandonRoom()
	
	get_tree().change_scene("res://scenes/gui/RoomList.tscn")


func _on_StartBtn_pressed():
	pass # Replace with function body.
