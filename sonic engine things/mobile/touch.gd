extends CanvasLayer

@onready var stick: Node2D = $stick

var Xdir
var Ydir

func _physics_process(delta: float) -> void:
	
	
	Xdir = stick.posVector.x
	Ydir = stick.posVector.y
	
	if Xdir > 0.6:
		Input.action_press("right")
		Input.action_release("left")
	if Xdir < -0.6:
		Input.action_press("left")
		Input.action_release("right")
	if Xdir == 0:
		Input.action_release("left")
		Input.action_release("right")
	if Ydir == 0:
		Input.action_release("down")
	if Ydir > 0.6:
		Input.action_release("up")
		Input.action_press("down")
	if Ydir < -0.6:
		Input.action_press("up")
		Input.action_release("down")
	if Ydir < 0.6:
		Input.action_release("down")
	
