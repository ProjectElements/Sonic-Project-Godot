extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var player: player = $"../Player"
@onready var camera_2d: Camera2D = $"../Camera2D"
var playercentered = false
@onready var collision_shape_2d2: CollisionShape2D = $"player detection/CollisionShape2D"
var positonatend 
var positionoffset = Vector2(-222, 0)

func _process(delta: float) -> void:
	positonatend = camera_2d.global_position + positionoffset
	if Global.isinendzone:
		collision_shape_2d.disabled = false
		if Global.signpostspun:
			collision_shape_2d2.disabled = true
			global_position = global_position
		elif !Global.signpostspun:
			collision_shape_2d2.disabled = false
			
		if player.motion.x > 1 and playercentered and !Global.signpostspun:
			global_position = positonatend
		else:
			global_position = global_position


func _on_player_detection_area_entered(area: Area2D):
	if area.is_in_group("player") and !playercentered:
		playercentered = true


func _on_player_detection_area_exited(area: Area2D):
	if area.is_in_group("player") and playercentered:
		playercentered = false
