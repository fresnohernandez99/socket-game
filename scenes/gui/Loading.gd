extends Node


var reason

onready var statuslabel = $Control/StatusLabel
onready var timer = $Timer

var changeTo = "res://scenes/gui/MainMenu.tscn"

func _ready():
	SocketManager.actualRootNode = get_node("/root")
	reason = GlobalNavigation.navReason
	GlobalNavigation.navReason = ""
	procced()
	

func _process(delta):
	match(reason):
		GlobalNavigation.NAV_FOR_CONNECT:
			onConnect()


func procced():
	match(reason):
		GlobalNavigation.NAV_FOR_CONNECT:
			_navForConnect()

################################################
###
### Region Loading actions
###
################################################

func _navForConnect():
	SocketManager.startConnection()

func onConnect():
	# Connecting
	if SocketManager.INTENT_CONNECTING_ACTIVE == SocketManager.LOADING_STATE:
		statuslabel.text = "Connecting..."
	elif SocketManager.INTENT_CONNECTING_ACTIVE == SocketManager.ERROR_STATE:
		statuslabel.text = "ERROR"
		timer.start()
	elif SocketManager.INTENT_CONNECTING_ACTIVE == SocketManager.SUCCESS_STATE:
			SocketManager.INTENT_CONNECTING_ACTIVE = SocketManager.NOT_REQUESTED_STATE
			statuslabel.text = "Uploading data"
			SocketManager.uploadInfo()
	
	#Upload user info to room
	if SocketManager.INTENT_UPLOAD_INFO_ACTIVE == SocketManager.SUCCESS_STATE:
		SocketManager.INTENT_UPLOAD_INFO_ACTIVE = SocketManager.NOT_REQUESTED_STATE
		changeTo = "res://scenes/gui/RoomList.tscn"
		timer.start()

################################################
###
###  End-Region Loading actions
###
################################################

func _on_Timer_timeout():
	get_tree().change_scene(changeTo)
