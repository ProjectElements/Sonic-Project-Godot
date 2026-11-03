extends TouchScreenButton
@onready var knob: Sprite2D = $knob
@onready var max_dist = shape.radius

var stick_cent: Vector2 = texture_normal.get_size() / 2
var touched: bool = false


func _ready():
	set_process(false)
	
	
func _input(event):
	
	if event is InputEventScreenDrag:
		#var i = event.index
		var dist = event.position.distance_to(knob.global_position)
		if event.relative and dist < max_dist:
			set_process(true)
		elif not event.relative or dist >= max_dist:
			set_process(false)
			knob.position = stick_cent

func _process(delta):
	knob.global_position = get_global_mouse_position()
	knob.position = stick_cent + (knob.position - stick_cent).limit_length(max_dist)
	
	
	
func get_joystick_dir() -> Vector2:
	var dir = knob.position  - stick_cent
	return dir.normalized()
	



		
