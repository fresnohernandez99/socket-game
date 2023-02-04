extends Control

onready var roomNamelabel = $RoomNameLabel
onready var roomPlayersLabel = $RoomPlayersLabel
onready var requestCodeDialog = $ConfirmationDialog
onready var codeLineEdit = $ConfirmationDialog/CodeLineEdit

var data
var configs

func setData(roomData, spaceConfiguration):
	data = roomData
	configs = spaceConfiguration
	
func _ready():
	roomNamelabel.text = data.name
	roomPlayersLabel.text = "Conectados: " + str(data.users.size()) + "/" + str(configs.maxPlayers)


func _on_ConnectBtn_pressed():
	requestCodeDialog.popup()


func _on_ConfirmationDialog_confirmed():
	SocketManager.joinRoom(data.id, codeLineEdit.text)
