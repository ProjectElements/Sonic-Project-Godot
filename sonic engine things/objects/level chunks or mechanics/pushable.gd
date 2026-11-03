extends RigidBody2D

var beinpushed = false
var rightside = false
var leftside = false

func _physics_process(delta: float) -> void:
	if beinpushed and rightside:
		global_position.x -= 0.8
	if beinpushed and leftside:	
		global_position.x += 0.8

func _on_right_area_entered(area: Area2D) -> void:
	if area.is_in_group("push"):
		beinpushed = true
		rightside = true


func _on_left_area_entered(area: Area2D) -> void:
	if area.is_in_group("push"):
		beinpushed = true
		leftside = true


func _on_left_area_exited(area: Area2D) -> void:
	if area.is_in_group("push"):
		beinpushed = false
		leftside = false

func _on_right_area_exited(area: Area2D) -> void:
	if area.is_in_group("push"):
		beinpushed = false
		rightside = false
