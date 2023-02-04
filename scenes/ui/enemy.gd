extends KinematicBody2D
var jugador = null 
var move  = Vector2.ZERO
var vel = 130  


signal start 

func _physics_process(delta):
	move = Vector2.ZERO
	
	if jugador != null:
		move = position.direction_to(jugador.position)
	  
	else: 
		move = Vector2.ZERO 
		
	move = move.normalized() * vel 
	move = move_and_slide(move)
	
func _on_distance_body_entered(body):
	if body.is_in_group("player"):
		jugador = body

func _on_distance_body_exited(body):
	jugador = null
	


func _on_start_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("start")
