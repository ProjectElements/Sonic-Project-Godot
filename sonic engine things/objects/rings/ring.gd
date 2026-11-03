extends Node2D
@onready var ringshape: CollisionShape2D = $"ring collision/ringshape"
var collected = false

func _process(delta: float):
	ringcollect()
func ringcollect():
	if collected: #if you collected this ring
		ringshape.disabled = true #disables the collection area
		if Global.currentlevelex:
			Levelscriptex.currentscore += 100
		$AnimatedSprite2D.play("ringcollected")
		$ring.play() #play the sound and animation
		$"disappear timer".start() #start timer til disappearance
		collected = false

func _on_ring_collision_area_entered(area: Area2D):
	if area.is_in_group("player"): #if player is in the ring area, collect it
		collected = true


func _on_disappear_timer_timeout() -> void:
	queue_free()
