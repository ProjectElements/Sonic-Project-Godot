extends Area2D


		
		


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("player is underwater")
		Global.isunderwater = true


func _on_area_exited(area: Area2D) -> void:
	
	if area.is_in_group("player"):
		Global.isunderwater = false
		print("player has left the water")
