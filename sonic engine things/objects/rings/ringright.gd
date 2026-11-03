extends RigidBody2D
@onready var ringshape: CollisionShape2D = $"ring collision/ringshape"
var collected = false
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float):
	 
	ringcollect()
func ringcollect():
	if collected:
		ringshape.disabled = true
		collision_shape_2d.disabled = true
		freeze = true
		animated_sprite_2d.play("ringcollected")
		$ring.play()
		$"disappear timer".start()
		collected = false

func _on_ring_collision_area_entered(area: Area2D):
	if area.is_in_group("player"):
		collected = true


func _on_disappear_timer_timeout() -> void:
	queue_free()


func _on_autodisappear_timeout() -> void:
	queue_free()
