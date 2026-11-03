extends AudioStreamPlayer
var diesound = false
var dienot = true
var explosiontimer = false
var explosoionrun = true

@onready var explodetime: Timer = $"../../musictimers/explodetime"
@onready var finaltimer: Timer = $"../../musictimers/finaltimer"

func _process(delta: float) -> void:
	if Global.bossdyingsfx:
		diesound = true
		explosiontimer = true
	if explosiontimer and explosoionrun:
		explodetime.start()
		explosoionrun = false
	elif !Global.bossdyingsfx:
		diesound = false
	
	if diesound and dienot:
		play()
		dienot = false

func _on_finished() -> void:
	dienot = true


func _on_explodetime_timeout() -> void:
	Global.bossraisesfx = true
	finaltimer.start()
