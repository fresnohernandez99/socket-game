extends Area2D

onready var tween = $Tween

var appearing = true

var speed = 1

func _ready():
	randomize()
	speed = rand_range(0, 2)
	appear()

func desappear():
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func appear():
	tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _physics_process(delta):
	position.x -= speed

func _on_Tween_tween_completed(object, key):
	if !appearing:
		self.position.x += 3000
		appear()
	else:
		appearing = false
