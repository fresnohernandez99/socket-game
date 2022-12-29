extends Control

onready var roomNamelabel = $RoomNameLabel
onready var roomPlayersLabel = $RoomPlayersLabel

var data

func setData(roomData):
	print(roomData)
	data = roomData
	
func _ready():
	roomNamelabel.text = data.name
	roomPlayersLabel.text = "Connected: " + str(data.users.size()) + "/" + str(data.configuration.maxPlayers)
