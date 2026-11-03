extends AudioStreamPlayer

var sfxplay = false
var sfxplaying = false
var ringsfx = false

func _process(delta: float) -> void:
	if Global.currentlevelex:
		if Levelscriptex.finalscore >= 100000:
			sfxplay = true
		elif Levelscriptex.currentscore < 100000:
			sfxplay = false
			sfxplaying = false
		
	
	if sfxplay and !sfxplaying:
		play()
		sfxplaying = true
	if Global.lifeobtmusic and !ringsfx:
		ringsfx = true
		play()
		print("lifeobtmus")
		

func _on_finished() -> void:
	Global.lifeobtmusic = false
	ringsfx = false
