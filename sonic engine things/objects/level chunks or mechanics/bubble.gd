extends RigidBody2D

var inflating = true
var bubblefloat = false
var bubblepop = false

var inflatetimer = true
@onready var bubanim: AnimatedSprite2D = $AnimatedSprite2D

@onready var inflatetime: Timer = $inflatetime
@onready var bubblefloattime: Timer = $bubblefloattime
@onready var disappeartime: Timer = $disappeartime
@onready var bubblecollision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var bubbletaken: Timer = $bubbletaken


func _physics_process(delta: float) -> void:
	if inflating:
		bubanim.play("inflate")
	if bubblefloat and !Global.pause:
		position.y -= 0.3
		bubanim.play("bub")
	if bubblepop:
		bubanim.play("pop")
		
	if inflating and inflatetimer:
		inflatetimer = false
		inflatetime.start()
	


func _on_inflatetime_timeout() -> void:
	inflating = false
	bubblefloat = true
	bubblecollision.disabled = false
	bubblefloattime.start()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		bubblefloat = false
		bubblepop = true
		bubbletaken.start()
		disappeartime.start()
		


func _on_bubblefloattime_timeout() -> void:
	bubblefloat = false
	bubblepop = true
	bubbletaken.start()
	disappeartime.start()
	


func _on_bubbletaken_timeout() -> void:
	bubblecollision.disabled = true
	


func _on_disappeartime_timeout() -> void:
	queue_free()
