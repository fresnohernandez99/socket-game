extends Node


var reason
var isWaiting = true

onready var statuslabel = $Control/StatusLabel
onready var timer = $Timer

func _ready():
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
	if isWaiting == true:
		if SocketManager.INTENT_CONNECTING_ACTIVE == SocketManager.LOADING_STATE:
			statuslabel.text = "Connecting..."
		elif SocketManager.INTENT_CONNECTING_ACTIVE == SocketManager.ERROR_STATE:
			isWaiting = false
			statuslabel.text = "ERROR"
			get_tree().change_scene("res://scenes/gui/MainMenu.tscn")
		elif SocketManager.INTENT_CONNECTING_ACTIVE == SocketManager.SUCCESS_STATE:
			isWaiting = false
			statuslabel.text = "Connected"
			timer.wait_time = 2
			timer.start()

################################################
###
###  End-Region Loading actions
###
################################################

func _on_Timer_timeout():
	match(reason):
		GlobalNavigation.NAV_FOR_CONNECT:
			get_tree().change_scene("res://scenes/gui/RoomList.tscn")
