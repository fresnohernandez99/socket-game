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

func setData(socketRoom):
	id = socketRoom.id
	roomOwner = socketRoom.owner
	roomName = socketRoom.name
	code = socketRoom.code
	users = socketRoom.users
