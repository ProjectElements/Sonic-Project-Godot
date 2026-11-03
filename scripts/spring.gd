class_name isspring
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group("player"): #if the player is in the area
		$AnimatedSprite2D.play("sprung") #plays the spring animation
		$spring.play() #and plays the spring sound
		$springanim.start() #starts a timer for the animation
		

func _on_springanim_timeout() -> void:
	$AnimatedSprite2D.play("default")
