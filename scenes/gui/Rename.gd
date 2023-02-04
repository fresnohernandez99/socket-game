extends Control
  
onready var NamePlayer = $Name/NameText
onready var Save = $Save
onready var famele = $Sex/Female
onready var male =$Sex/Male


func _ready():
	  NamePlayer.text = Persistence.data.namePlayer.name

func _process(delta):

	if NamePlayer.text == "":
		if male.pressed == false:
				$Save.disabled = true
	else:
		$Save.disabled = false

func _on_Cancel_pressed():
	get_tree().change_scene("res://scenes/gui/MainMenu.tscn")

func _on_Save_pressed():
	
	Persistence.data.namePlayer.name = NamePlayer.text
	Persistence.data.hero.name = NamePlayer.text
	Persistence.save_data()   
	get_tree().change_scene("res://scenes/gui/MainMenu.tscn")
	
	
