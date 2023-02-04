extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var music = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	music.volume_db = int(Persistence.data.option.volume / 10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResetCloudArea_area_entered(area):
	if area.is_in_group("cloud"):
		area.desappear()
