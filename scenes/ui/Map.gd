extends Node2D


onready var music = $AudioStreamPlayer2D

onready var tween = $InitBattleAnimation/Tween

onready var up = $InitBattleAnimation/Square1/AnimEnteredUp
onready var containerUp = $InitBattleAnimation/Square1
onready var down = $InitBattleAnimation/Square2/AnimEnteredDown
onready var containerDown = $InitBattleAnimation/Square2

onready var player = $Runningplayer
onready var playerCamera = $Runningplayer/Camera2D

onready var monsterLabel = $Enemies/Monster/RichTextLabel

func _ready():
	music.volume_db = int(Persistence.data.option.volume / 10)
	
func _on_ResetCloudArea_area_entered(area):
	if area.is_in_group("cloud"):
		area.desappear()

func _on_Enemy_start():
	player.canMove = false
	
	var initPosUp = player.global_position
	initPosUp.x -= 1000
	
	containerUp.show()
	
	tween.interpolate_property(up, "global_position", initPosUp, player.global_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
	var initPosDown = player.global_position
	initPosDown.x +=  1000
	
	containerDown.show()
	
	tween.interpolate_property(down, "global_position", initPosDown, player.global_position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
	tween.interpolate_property(playerCamera, "zoom", Vector2(1, 1), Vector2(0.6, 0.6), 3.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func _on_Tween_tween_all_completed():
	get_tree().change_scene("res://scenes/ui/CombatSceneIA.tscn")


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		monsterLabel.hide()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		monsterLabel.show()
