extends Control
  
onready var NamePlayer = $Name/NameText
onready var Save = $Save
onready var famele = $Sex/Female
onready var male =$Sex/Male


func _ready():
	  NamePlayer.text=Persistence.data.namePlayer.name

func _process(delta):

	if NamePlayer.text == "":
		if male.pressed == false:
				$Save.disabled = true
