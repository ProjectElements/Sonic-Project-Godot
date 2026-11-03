extends Camera2D
@export var target: Node2D
@export var leftedgelimit: Node2D
@export var rightedgelimit: Node2D
@export var endlevelleft = 9550
@export var endlevelbottom = -300
var currentborder = rightedgelimit

func _physics_process(delta: float) -> void:
	if target and !Global.sonicdied:
		global_position = target.global_position
	elif Global.sonicdied:
		global_position = global_position
	if Global.isinendzone:
		if endlevelbottom > -550:
			endlevelbottom -= 3
	if Global.isinendzone and !Global.signpostspun:
		set_limit(SIDE_LEFT,leftedgelimit.position.x)
		set_limit(SIDE_BOTTOM,endlevelbottom)
	elif Global.isinendzone and Global.signpostspun:
		set_limit(SIDE_LEFT,endlevelleft)
		set_limit(SIDE_BOTTOM,endlevelbottom)
	if Global.currentlevelbossex and !Global.bosslevelstart and !Global.bossdefeated and !Global.bossclearscreen and !Global.calculatingfinalscore and !Global.bosslevelfinished:
		set_limit(SIDE_LEFT,leftedgelimit.global_position.x)
		set_limit(SIDE_RIGHT,rightedgelimit.global_position.x)
	if Global.bossdefeated and Global.currentlevelbossex and !Global.bosslevelstart or Global.bossclearscreen or Global.calculatingfinalscore or Global.bosslevelfinished:
		set_limit(SIDE_LEFT,-100000000000000)
		
		set_limit(SIDE_RIGHT,100000000000000)
