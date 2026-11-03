extends AudioStreamPlayer

var musicplaying = true

func _process(delta: float) -> void:
	if musicplaying and Global.drownmusic:
		musicplaying = false
		play()
	elif !Global.drownmusic:
		musicplaying = true
		stop()
