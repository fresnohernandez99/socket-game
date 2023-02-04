extends StaticBody2D

onready var textoAyuda = $ColorRect/TextDeAyuda
onready var rect = $ColorRect
onready var amigo 

var nombrePlayer = Persistence.data.namePlayer.name 

var a = [
	" - Hola " + "[color=red]" + nombrePlayer + "[/color]" + " \n- Que bien que ya estás listo. Ya te has familiarizado con tu ídolo heredado? Recuerda que toda tu línea de antepasados definen quien eres y te dan fuerzas.",
	" - Hola " + "[color=red]" + nombrePlayer + "[/color]" + " \n- Estamos bajo asedio. Los de los barrios altos han tomado la delantera y están entrenando fuerte para conquistar el pueblo. Combate contra ellos para obtener experiencia.",
	" - Hola " + "[color=red]" + nombrePlayer + "[/color]" + " \n-Ya que estás al tanto de la situación deberías saber también que si subes de nivel podrás aprender nuevos movimientos de combate",
	" - Hola " + "[color=red]" + nombrePlayer + "[/color]" + " \n- Tú ídolo define tu forma de ataque y te da poderes que desbordan la imaginación. Existen hasta 40 tipos distintos de ataques únicos por cada ídolo familiar."
]

export (int) var idAmigo 
 

func _ready():
	textoAyuda.bbcode_text = a[idAmigo]




func _on_Area2D_body_entered(body):
	textoAyuda.visible = true
	rect.visible = true 


func _on_Area2D_body_exited(body):
	textoAyuda.visible = false
	rect.visible = false


#if idAmigo == 3:
#		textoAyuda.bbcode_text == "holaa3"
#		textoAyuda.visible = true
#		rect.visible = true 
