extends Control


onready var menuBtn = $MenuButton
var popup

func _ready():
	popup = menuBtn.get_popup()
	popup.add_item("Resetear")
	popup.add_item("Opciones")
	popup.add_item("Salir")
	popup.connect("id_pressed", self, "_on_item_pressed")

func _on_item_pressed(ID):
	match ID:
		0:
			goToStart()
		1:
			goToSettings()
		2:
			exitGame()

func goToStart():
	SocketManager.closeConnection()
	get_tree().change_scene("res://scenes/gui/MainMenu.tscn")

func goToSettings():
	pass

func exitGame():
	get_tree().quit()
