extends Node

onready var descriptionLabel = $Control/ScrollContainer/VBoxContainer/DescriptionLabel
const ClassHandler = preload("res://scripts/engine/ClassHandler.gd")

var classHandler = ClassHandler.new()

func _ready():
	for i in SocketRooms.nextToUse:
		SocketRooms.names.push_back(i)
	
	
	SocketManager.actualRootNode = get_node("/root")
	
	descriptionLabel.text += Persistence.data.hero.name + " detalles:" + "\n"
	descriptionLabel.text += "LV: " + str(Persistence.data.hero.level) + "\n"
	descriptionLabel.text += "Próximo nivel a : " + str(Persistence.data.hero.nextLevelOn - Persistence.data.hero.nextLevelOnEarned) + "\n\n"
	
	
	descriptionLabel.text += "Ídolo: " + classHandler.getClassName(Persistence.data.hero) + "\n"
	descriptionLabel.text += "Bio: \n" + classHandler.getClassDescription(Persistence.data.hero) + "\n\n"
	
	
	descriptionLabel.text += "Puntos de estado: " + "\n"
	var stats = Persistence.data.hero.stats
	for i in range(stats.size()):
		descriptionLabel.text += classHandler._getStatName(i) + " : " + str(stats[i].value) + "\n"
	
	descriptionLabel.text += "\nMovimientos: " + "\n"
	
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


func _on_ExitBtn_pressed():
	get_tree().quit()
