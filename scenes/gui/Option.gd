extends Control

 
var Bandera
var volume 

onready var nodoVolume = $Volume/HSlider
onready var nodoLabelVolume = $Volume/labelVolume
onready var nodoIPText = $IP/IPtext
onready var nodoIPValidInvalid = $IP/validInvalid
onready var Savebtn = $Savebtn
onready var nodoPort = $PORT/PORTtext

var salvasOpcion = Persistence.data.option

func _ready():
	nodoIPText.text = salvasOpcion.ip
	nodoPort.text =  salvasOpcion.port
	print( salvasOpcion.volume)
	nodoVolume.value = int(salvasOpcion.volume)
	 

func _process(delta):
	
	volume = nodoVolume.value
	nodoLabelVolume.text = str(volume)+"%"
	
	
	if  nodoIPText.text !="" && isValidedIP() && isValidarPort() :
		nodoIPValidInvalid.text = "valid"
		Savebtn.disabled = false
	else:
		Savebtn.disabled = true
		


func isValidedIP():
	 var regex = RegEx.new()
	 regex.compile( "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\." +
					"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\." +
					"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\." +
					"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
					
	 var result = regex.search(nodoIPText.text)
	
	
#	 regularexp = RegEx.new()
#	 regularexp.compile("")
#	 var result2 = regularexp.search(nodoIPText.text)
#     result2 != null
	 if result != null  || nodoIPText.text == "localhost"  :
			return true
		
func isValidarPort():
	var regex2 = RegEx.new()
	regex2.compile("^([0-9])*$")   
	
	var resul = regex2.search(nodoPort.text)
	if resul != null && nodoPort.text != "":
		return  true
	else:
		return false 




func _on_Savebtn_pressed():
	salvasOpcion.ip = nodoIPText.text
	salvasOpcion.port = nodoPort.text
	Persistence.save_data()
	get_tree().change_scene("res://scenes/gui/MainMenu.tscn")
	



func _on_Cancelbtn_pressed():
	get_tree().change_scene("res://scenes/gui/MainMenu.tscn")
