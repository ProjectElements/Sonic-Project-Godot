extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $signpostarea/CollisionShape2D
@onready var signpostsound: AudioStreamPlayer = $signpostsound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var sonicinteracted = false
var soundplay = false
var levelend = false

func _process(delta: float):
	if sonicinteracted and !Global.sonicpassedsign:
		if !soundplay and sonicinteracted:
			signpostsound.play()
			soundplay = true
		
		Global.signpostspun = true
		animated_sprite_2d.play("spinning")
		await get_tree().create_timer(3.0).timeout
		animated_sprite_2d.play("donespinning")
		if !levelend and sonicinteracted:
			print("signpostdone")
			Global.sonicpassedsign = true
			Global.levelclearscreen = true
			levelend = true	
		sonicinteracted = false
	
	if Global.levelfinished:
		sonicinteracted = false
		soundplay = false
		levelend = false
		Global.signpostspun = false
		Global.sonicpassedsign = false
		Global.levelclearscreen = false
		Global.levelfinished = false
		
	#if !levelend and sonicinteracted:
	#	print("signpostdone")
	#	Global.sonicpassedsign = true
	#	Global.levelclearscreen = true
	#	levelend = true	


	

func _on_signpostarea_area_entered(area: Area2D):
	if area.is_in_group("player") and !Global.sonicpassedsign and !Global.levelclearscreen and !sonicinteracted:
		sonicinteracted = true
		Global.pausedisabled = true


func _on_levelendarea_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Global.isinendzone = true
