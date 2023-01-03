extends Control


onready var playerNamelabel = $PlayerNameLabel
onready var playerLevelLabel = $PlayerLevelLabel
onready var kickBtn = $KickBtn

var data
var imOwner: bool

func setData(playerData, imOwner: bool):
	data = playerData
	self.imOwner = imOwner
	
func _ready():
	if !imOwner or data.playerId == Session.playerId:
		kickBtn.hide()
	
	playerNamelabel.text = data.name
	#playerLevelLabel.text = "LV: " + str(data.any)


func _on_KickBtn_pressed():
	pass # Replace with function body.
