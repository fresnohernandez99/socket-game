extends Node2D



onready var music = $AudioStreamPlayer2D
onready var amigo1 = $Amigo
onready var amigo2 = $Amigo2
onready var amigo3 = $Amigo3



func _ready():
	music.volume_db = int(Persistence.data.option.volume / 10)
	
func _on_ResetCloudArea_area_entered(area):
	if area.is_in_group("cloud"):
		area.desappear()
