extends Node


var id: String
var roomOwner: String
var roomName: String
var code: String
var closed = false
var configuration = {
	
}
var users = []
var lastDisconnectedUser = ""

var usersInfo = []

# To show player status
var allPlayersReady = false
var lastPlayerReady: String

# To reproduce player actions
var roundResult

func setData(socketRoom, configurations):
	id = socketRoom.id
	roomOwner = socketRoom.owner
	roomName = socketRoom.name
	code = socketRoom.code
	users = socketRoom.users
	
	self.configuration = configurations
