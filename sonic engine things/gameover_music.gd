extends AudioStreamPlayer
var gameov = false
var cangame = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Global.gameover: #if you gameover
		gameov = true
	if gameov and cangame: #starts a timer 
		await get_tree().create_timer(1.3).timeout #when it stops
		play() #play gameover theme
		gameov = false
		cangame = false
	
