extends Control


export var message = "Example"
export var message_delay = 1.5
export var cascading_delay = 0.1

onready var text = $RichTextLabel

export var start_delay = 0.8

var color

var char_timers

func _ready():
	set_physics_process(false)

func start(text, color = Color(0,1,0,0)):
	self.color = color
	yield(get_tree().create_timer(start_delay), "timeout")
	fade_text(message, message_delay, cascading_delay)
	text.bbcode_text = message

func fade_text(string, duration, cascading_delay):
	char_timers = []
	var i = 0

	for c in string: # Characters in string.
		char_timers.append ({
			letter   = c,
			delay    = cascading_delay * i,
			count    = duration,
			duration = duration,
		})
		i += 1
	set_physics_process(true)

func _physics_process(delta):
	var is_active = false
	text.bbcode_text = ""

	var idx = 0

	for c_timer in char_timers:
		if(c_timer.delay > 0.0):
			is_active = true
			c_timer.delay -= delta
			color.a = 1.0
		else:
			if(c_timer.count > 0.0):
				is_active = true
				c_timer.count -= delta
				color.a = max(c_timer.count / c_timer.duration, 0.0)
		
		text.bbcode_text += '[color=#' + color.to_html() + ']' + c_timer.letter + '[/color]'
	set_physics_process(is_active)
	
	#if !is_active:
	#	queue_free()
