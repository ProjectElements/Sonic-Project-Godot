extends Timer

var gameov = false
var cangame = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Levelscriptex.endoflev: #if you gameover
		gameov = true
	if gameov and cangame: #starts a timer 
		start()
		gameov = false
		cangame = false
