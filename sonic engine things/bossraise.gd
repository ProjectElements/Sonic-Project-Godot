extends AudioStreamPlayer
var eggraisesfx = false
var eggraisesnot = true

func _process(delta: float) -> void:
	if Global.bossraisesfx:
		eggraisesfx = true
		Global.bossraisesfx = false
		
	if eggraisesfx and eggraisesnot:
		play()
		eggraisesnot = false
