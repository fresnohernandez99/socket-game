extends Node



func _on_MultiPlayerBtn_pressed():
	GlobalNavigation.navReason = GlobalNavigation.NAV_FOR_CONNECT
	get_tree().change_scene("res://scenes/gui/Loading.tscn")
