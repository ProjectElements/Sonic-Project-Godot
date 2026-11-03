extends AudioStreamPlayer
var pinch = false
var canpinch = true



func _physics_process(delta: float):
	if Global.bosspinch: 
		pinch = true
	if pinch and canpinch: 
		play() 
		pinch = false
		canpinch = false
	if Global.bosslevelfinished:
		canpinch = true
		pinch = false
	if Global.sonicdied and !Global.gameover:
		await get_tree().create_timer(5.0).timeout
		stop()
		canpinch = true
		pinch = false
		
	if Global.gameover: #if you gameover
		#await get_tree().create_timer(1.3).timeout #waits for this timer
		await get_tree().create_timer(1.3).timeout
		canpinch = true
		pinch = false
		stop() #and stops the level music
	if Global.bossclearscreen:
		stop()
