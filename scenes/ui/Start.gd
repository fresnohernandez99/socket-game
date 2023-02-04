extends Node


onready var story1 = $StoryLv1
onready var label = $ScrollContainer/MessageLabel
onready var tween = $Tween
onready var finalPos = $Position2D

onready var images = [$Hercules, $Ochosi, $Susanoo, $Templar, $Veles]

var cont = 0

var texts = [
	"... En un apagón de la Habana por allá por el año 2022 ...",
	"Un niño protestaba desconsolado por el aburrimiento que le atacaba.",
	"Se siente una voz vacía ...",
	"- Nieto mío. Esta historia que te cuento no es mía, ni de mi abuelo, ni de el abuelo de mi abuelo ...",
	"Esta es la historia de todos los que estábamos antes de que un celular o una computadora dominara la atención de los niños.",
	"... Antes de esos trastes era nuestra mente la que reinaba en las horas de diversión ...",
	"Si una mente es capaz de imaginar todo un mundo nuevo ... piensa cuanto poder tenía la unión de todas las pequeñas mentes que nos llamamos aún amigos ...",
	"Y era así como de antepasados y de historias se hacían realidad las mejores fantasías ...",
	"Esas ... son las raíces de la diversión y las grandes ideas ..."
]

func _ready():
	showFade(story1)
	label.bbcode_text = texts[cont]

func showFade(obj: Sprite):
	tween.interpolate_property(obj, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN)

func showFadeAndMove(obj: Sprite):
	tween.interpolate_property(obj, "position", obj.position, finalPos.position, 4.0, Tween.TRANS_LINEAR, Tween.EASE_IN)


func _on_NextBtn_pressed():
	if cont == 1:
		tween.start()

	if cont == 4:
		startTransition()

	if cont < texts.size() -1:
		cont += 1
		label.bbcode_text = texts[cont]
	else:
		pass

func startTransition():
	var cont2 = 0
	while cont2 < images.size():
		yield(get_tree().create_timer(1), "timeout")
		showFadeAndMove(images[cont2])
		showFade(images[cont2])
		tween.start()
		cont2 +=1
