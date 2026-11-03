extends AudioStreamPlayer

var sfxplay = false
var sfxplaying = false


func _process(delta: float) -> void:
	if Global.currentlevelex:
		if Levelscriptex.finalamountupdated:
			sfxplay = true
		elif !Levelscriptex.finalamountupdated:
			sfxplay = false
		if sfxplay and !sfxplaying and Levelscriptex.finalamountupdated:
			play()
			sfxplaying = true
	if Global.currentlevelbossex:
		if Exampleboss.finalamountupdated:
			sfxplay = true
		elif !Exampleboss.finalamountupdated:
			sfxplay = false
		if sfxplay and !sfxplaying and Exampleboss.finalamountupdated:
			play()
			sfxplaying = true
			
## blank for any level clear sfx (denoted with _ )
	#if Global.currentlevel_:
	#	if Levelscript_.finalamountupdated:
	#		sfxplay = true
	#	elif !Levelscript_.finalamountupdated:
	#		sfxplay = false
	#	if sfxplay and !sfxplaying and Levelscript_.finalamountupdated:
	#		play()
	#		sfxplaying = true

func _on_finished() -> void:
	sfxplaying = false
