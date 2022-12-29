extends Node


var roomItem = load("res://scenes/gui/RoomItem.tscn")
#onready var ins_nave2_roja = nave2_roja.instance()

func _ready():
	loadRooms()

func loadRooms():
	SocketManager.loadRooms()

func _on_AddRoomBtn_pressed():
	get_tree().change_scene("res://scenes/gui/CreateRoom.tscn")
