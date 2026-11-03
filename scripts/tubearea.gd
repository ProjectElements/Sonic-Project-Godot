extends Area2D
@onready var tubesfx: AudioStreamPlayer = $tubesfx

var canplay = true
var playing = true
func _process(delta: float):
	if canplay and !playing:
		tubesfx.play()
		canplay = false

func _on_area_entered(area: Area2D):
	if is_in_group("player"):
		playing = false
		

func _on_area_exited(area: Area2D):
	if is_in_group("player"):
		canplay = true
		playing = true
