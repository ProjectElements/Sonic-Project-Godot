extends AudioStreamPlayer

func _ready() -> void:
	play() #plays level theme

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Global.gameover: #if you gameover
		await get_tree().create_timer(1.3).timeout #waits for this timer
		stop() #and stops the level music
	if Global.levelclearscreen:
		stop()
	if Global.bosspinch:
		stop()	
	if Global.isunderwater and !Global.drownmusic:
		volume_db = -15
	elif Global.drownmusic or Global.diedunderwater or Global.lifeobtmusic:
		volume_db = -80
	elif !Global.isunderwater:
		volume_db = 0
