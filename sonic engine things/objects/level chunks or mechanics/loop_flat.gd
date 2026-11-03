extends StaticBody2D

@onready var loopfront: CollisionPolygon2D = $loopfront
@onready var loopback: CollisionPolygon2D = $loopback
#allows you to change collision using variables
var loopfrontdisable = true
var loopbackdisable = false
var canchange = true

@onready var schk1: CollisionShape2D = $"sonic front check/CollisionShape2D"
@onready var schk2: CollisionShape2D = $"sonic back check/CollisionShape2D"


#detects which part of the loop needs to be disabled

func _process(delta: float):
	if loopfrontdisable and !loopbackdisable:
		loopfront.disabled = true
		loopback.disabled = false
		
		canchange = true
		#checks if loops need to be disabled and disables the respective side
	if loopbackdisable and !loopfrontdisable:
		loopback.disabled = true
		loopfront.disabled = false
		
		canchange = true


func _on_sonic_checker_area_entered(area: Area2D):
	pass


func _on_sonic_checker_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"): # if a player is exiting the area
		if loopfrontdisable and !loopbackdisable and canchange: #checks which side is active and which is disabled
			loopbackdisable = true #sets variables to disable and enable the respective sides
			loopfrontdisable = false
			canchange = false
			schk1.disabled = false
			schk2.disabled = true
			print("loop front")
		if loopbackdisable and !loopfrontdisable and canchange:
			loopbackdisable = false
			loopfrontdisable = true
			schk2.disabled = false
			schk1.disabled = true
			canchange = false
			print("back")


func _on_sonic_front_check_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"): # if a player is exiting the area
		if loopfrontdisable and !loopbackdisable and canchange: #checks which side is active and which is disabled
			loopbackdisable = true #sets variables to disable and enable the respective sides
			loopfrontdisable = false
			canchange = false
			schk1.disabled = false
			schk2.disabled = true
			print("loop front")
		if loopbackdisable and !loopfrontdisable and canchange:
			loopbackdisable = false
			loopfrontdisable = true
			schk2.disabled = false
			schk1.disabled = true
			canchange = false
			print("back")


func _on_sonic_back_check_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"): # if a player is exiting the area
		if loopfrontdisable and !loopbackdisable and canchange: #checks which side is active and which is disabled
			loopbackdisable = true #sets variables to disable and enable the respective sides
			loopfrontdisable = false
			canchange = false
			schk1.disabled = false
			schk2.disabled = true
			print("loop front")
		if loopbackdisable and !loopfrontdisable and canchange:
			loopbackdisable = false
			loopfrontdisable = true
			schk2.disabled = false
			schk1.disabled = true
			canchange = false
			print("back")
