extends Node


var isOwner = false

func _ready():
	if Session.playerId == RoomInfo.roomOwner:
		isOwner = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CancelBtn_pressed():
	if isOwner:
		SocketManager.cancelRoom()
	else:
		SocketManager.leaveRoom()
	
	get_tree().change_scene("res://scenes/gui/RoomList.tscn")


func _on_StartBtn_pressed():
	pass # Replace with function body.
