extends Node2D

func _ready() -> void:
	$backbutton.grab_focus()

func _on_backbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/titlescreen.tscn")
