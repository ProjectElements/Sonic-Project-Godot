extends Node2D
@export var eggman: Node2D
@export var sonic: Node2D
@onready var leftborder: CollisionShape2D = $leftborder/CollisionShape2D
@onready var rightborder: CollisionShape2D = $rightborder/CollisionShape2D

func _process(delta: float) -> void:
	if Global.bosslevelstart:
		global_position = sonic.global_position
		leftborder.disabled = false
		rightborder.disabled = false
	else:
		global_position = eggman.global_position
	if Global.bossdefeated or Global.bossclearscreen or Global.calculatingfinalscore or Global.egghammerbossdefeated:
		leftborder.disabled = true
		rightborder.disabled = true
	if Global.sonicdied:
		global_position = sonic.global_position
	
