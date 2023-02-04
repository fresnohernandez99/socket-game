extends Node

onready var descriptionLabel = $Control/ScrollContainer/VBoxContainer/DescriptionLabel

func _ready():
	SocketManager.actualRootNode = get_node("/root")
	
	descriptionLabel.text += Persistence.data.hero.name + " details:" + "\n"
	descriptionLabel.text += "LV: " + str(Persistence.data.hero.level) + "\n"
	descriptionLabel.text += "Class: " + Persistence.data.hero.charClass.name + "\n\n"
	
	descriptionLabel.text += "Stats: " + "\n"
	var stats = Persistence.data.hero.stats
	for i in range(stats.size()):
		descriptionLabel.text += stats[i].name + " : " + str(stats[i].value) + "\n"
	
	descriptionLabel.text += "\nMoves: " + "\n"
	
	var moves = Persistence.data.hero.moves
	for i in range(moves.size()):
		descriptionLabel.text += Persistence.heroHandler.getMoveName(moves[i].id, Persistence.data.hero.charClass.name) + "\n"


func _on_MultiPlayerBtn_pressed():
	GlobalNavigation.navReason = GlobalNavigation.NAV_FOR_CONNECT
	get_tree().change_scene("res://scenes/gui/Loading.tscn")


func _on_OptionsBtn_pressed():
	get_tree().change_scene("res://scenes/gui/Option.tscn")


func _on_Perfil_pressed():
	get_tree().change_scene("res://scenes/gui/Rename.tscn")


func _on_SinglePlayerBtn_pressed():
	get_tree().change_scene("res://scenes/ui/Map.tscn")
