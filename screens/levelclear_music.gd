extends AudioStreamPlayer
var levelclearedmusic = false
var levelclearplay = true

func _process(delta: float):
	if Global.levelclearscreen:
		levelclearedmusic = true
	if levelclearedmusic and levelclearplay:
		play()
		levelclearplay = false
	if Global.levelfinished:
		levelclearplay = true
		levelclearedmusic = false
	if Global.bossclearscreen:
		levelclearedmusic = true
	if levelclearedmusic and levelclearplay:
		play()
		levelclearplay = false
	if Global.bosslevelfinished:
		levelclearplay = true
		levelclearedmusic = false
