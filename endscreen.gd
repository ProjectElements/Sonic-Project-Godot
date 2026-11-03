extends Node2D

func _ready() -> void:
	$return.grab_focus()

func _on_return_pressed() -> void:
	Scenemanagement.title = true
	if Progress.lifecount < 3:
		Progress.lifecount = 3
	if Global.file1:
		Progress.save()
	if Global.file2:
		Progress.save2()
	if Global.file3:
		Progress.save3()
	
	Global.file1 = false
	Global.file2 = false
	Global.file3 = false
