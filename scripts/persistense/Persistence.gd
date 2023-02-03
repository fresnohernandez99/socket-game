extends Node


const PATH = "user://game_save.dat"
const PASS = "dbz1985"
const HeroHandler = preload("res://scripts/engine/HeroHandler.gd")


var is_loaded = false
var option = {
	"ip": '10.0.0.1',
	"volume" : "100",
	"port" : "8080"
}
var namePlayer = {
	 "name":"Player",
	 "sexo":" " 
}
var data = {
	"option": option,
	"namePlayer": namePlayer 
}

var heroHandler = HeroHandler.new()

func _ready():
	var file = File.new()
	
	if file.file_exists(PATH):
		load_data()
	else:
		var myHero = heroHandler.generateInitialHero()
		
		data.hero = myHero
		
		save_data()
		load_data()

func save_data():
	var file = File.new()
	
	file.open_encrypted_with_pass(PATH, File.WRITE, PASS)
	file.store_var(data)
	file.close()
	
	is_loaded = false

func load_data():
	if is_loaded:
		return
	var file = File.new()
	
	file.open_encrypted_with_pass(PATH, File.READ, PASS)
	data = file.get_var()
	file.close()
	
	is_loaded = true
