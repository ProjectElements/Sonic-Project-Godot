extends Camera2D

@export var mouse: InputEventMouse
#var spd = 100
#var radiusrequired = 65



#func _process(delta: float):
	#global_position = mouse.global_position
	#var mousepos = get_global_mouse_position()
	#var mousedelta = mousepos - global_position
	#if (mousedelta.length() >= radiusrequired):
	#1	position += (mousedelta / radiusrequired) * spd * delta
	
