extends Control

onready var roomNamelabel = $RoomNameLabel
onready var roomPlayersLabel = $RoomPlayersLabel
onready var requestCodeDialog = $ConfirmationDialog
onready var codeLineEdit = $ConfirmationDialog/CodeLineEdit

var data

func setData(roomData):
	data = roomData
	
func _ready():
	roomNamelabel.text = data.name
	roomPlayersLabel.text = "Connected: " + str(data.users.size()) + "/" + str(data.configuration.maxPlayers)


func _on_ConnectBtn_pressed():
	requestCodeDialog.popup()


func _on_ConfirmationDialog_confirmed():
	SocketManager.joinRoom(data.id, codeLineEdit.text)
