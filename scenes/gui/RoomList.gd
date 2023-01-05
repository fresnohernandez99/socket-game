extends Node

onready var listContainer = $Control/ScrollContainer/VBoxContainer

var roomItem = load("res://scenes/gui/RoomItem.tscn")

func _ready():
	SocketManager.actualRootNode = get_node("/root")
	loadRooms()

func _process(delta):
	if SocketManager.INTENT_GET_ROOMS_ACTIVE == SocketManager.SUCCESS_STATE:
		onRoomsLoaded()
	if SocketManager.INTENT_JOIN_ROOM_ACTIVE == SocketManager.SUCCESS_STATE:
		onJoinRoom()

func loadRooms():
	SocketManager.loadRooms()

func onRoomsLoaded():
	SocketManager.INTENT_GET_ROOMS_ACTIVE = SocketManager.NOT_REQUESTED_STATE
	
	var contR = 0
	while(contR < listContainer.get_child_count()):
		var theChild = listContainer.get_child(contR)
		listContainer.remove_child(theChild)
		contR += 1
	
	var cont = 0
	while(cont < SocketRooms.roomsWithConfigs.size()):
		var ins = roomItem.instance()
		ins.setData(SocketRooms.roomsWithConfigs[cont].room, SocketRooms.roomsWithConfigs[cont].spaceConfiguration)
		
		listContainer.add_child(ins)
		cont += 1

func onJoinRoom():
	SocketManager.INTENT_JOIN_ROOM_ACTIVE = SocketManager.NOT_REQUESTED_STATE
	get_tree().change_scene("res://scenes/gui/WaitingLobby.tscn")

func _on_AddRoomBtn_pressed():
	get_tree().change_scene("res://scenes/gui/CreateRoom.tscn")


func _on_RefreshBtn_pressed():
	loadRooms()
