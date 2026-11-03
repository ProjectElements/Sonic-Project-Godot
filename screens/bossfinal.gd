extends AudioStreamPlayer
var finalex = false
var finalnot = true

func _process(delta: float) -> void:
	if finalex and finalnot:
		play()
		finalnot = false

func _on_finaltimer_timeout() -> void:
	finalex = true
	Global.whitescreen = true
	Global.bossdyingsfx = false
