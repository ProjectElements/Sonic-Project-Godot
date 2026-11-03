extends RigidBody2D
@export var player: Node2D
func _process(delta: float) -> void:
	if !Global.isinendzone:
		global_position = player.global_position
	elif Global.isinendzone:
		global_position = global_position
