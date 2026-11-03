extends Node
var levelselectscn = false
var levelex = false
var levelbossex = false
var title = false
var end = false

func _process(delta: float) -> void:
	if levelselectscn:
		get_tree().reload_current_scene()
		print("load")
		get_tree().change_scene_to_file("res://screens/level_select.tscn")
		levelselectscn = false
		levelex = false
		levelbossex = false
		Global.inlevel = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if levelex:
		get_tree().reload_current_scene()
		print("load")
		get_tree().change_scene_to_file("res://screens/example_scene.tscn")
		levelex = false
		levelselectscn = false
		levelbossex = false
		
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if levelbossex:
		get_tree().reload_current_scene()
		print("load")
		get_tree().change_scene_to_file("res://screens/exampleboss.tscn")
		levelex = false
		levelselectscn = false
		levelbossex = false
		
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if title:
		get_tree().reload_current_scene()
		print("load")
		get_tree().change_scene_to_file("res://screens/titlescreen.tscn")
		title = false
		
	if end:
		get_tree().reload_current_scene()
		print("load")
		get_tree().change_scene_to_file("res://screens/endscreen.tscn")
		end = false
		levelselectscn = false
		levelex = false
		levelbossex = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
