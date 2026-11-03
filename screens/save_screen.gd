extends Node2D
var fileoptionmen = false
@onready var file_1: Button = $file1
@onready var file_2: Button = $file2
@onready var file_3: Button = $file3
@onready var nosave: Button = $nosave
@onready var pausebutton: CanvasLayer = $pausebutton

@onready var fileoptions: CanvasLayer = $fileoptions
@onready var fileoptxt: Label = $fileoptions/Label
@onready var loaddata: Button = $fileoptions/loaddata
@onready var deletedata: Button = $fileoptions/deletedata
@onready var back: Button = $fileoptions/back


@onready var areyousure: Label = $fileoptions/areyousure
@onready var yes: Button = $fileoptions/yes
@onready var no: Button = $fileoptions/no

func _ready() -> void:
	$file1.grab_focus()

func _on_file_1_pressed() -> void:
	#$fileoptions/loaddata.grab_focus()
	Global.file1 = true
	Global.file2 = false
	Global.file3 = false
	file_1.visible = false
	file_2.visible = false
	file_3.visible = false
	nosave.visible = false
	pausebutton.visible = false
	fileoptions.visible = true
	$fileoptions/loaddata.grab_focus()
	
	


func _on_file_2_pressed() -> void:
	
	Global.file1 = false
	Global.file2 = true
	Global.file3 = false
	file_1.visible = false
	file_2.visible = false
	file_3.visible = false
	nosave.visible = false
	pausebutton.visible = false
	fileoptions.visible = true
	$fileoptions/loaddata.grab_focus()

func _on_file_3_pressed() -> void:
	
	Global.file1 = false
	Global.file2 = false
	Global.file3 = true
	file_1.visible = false
	file_2.visible = false
	file_3.visible = false
	nosave.visible = false
	pausebutton.visible = false
	fileoptions.visible = true
	$fileoptions/loaddata.grab_focus()


func _on_touch_screen_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/titlescreen.tscn")


func _on_nosave_pressed() -> void:
	Global.file1 = false
	Global.file2 = false
	Global.file3 = false
	Progress.nosave()
	get_tree().change_scene_to_file("res://screens/level_select.tscn")


func _on_loaddata_pressed() -> void:
	if Global.file1:
		Progress.load_data()
		get_tree().change_scene_to_file("res://screens/level_select.tscn")
	if Global.file2:
		Progress.load_2()
		get_tree().change_scene_to_file("res://screens/level_select.tscn")
	if Global.file3:
		Progress.load_3()
		get_tree().change_scene_to_file("res://screens/level_select.tscn")


func _on_deletedata_pressed() -> void:
	fileoptxt.visible = false
	loaddata.visible = false
	deletedata.visible = false
	back.visible = false
	areyousure.visible = true
	yes.visible = true
	no.visible = true
	$fileoptions/no.grab_focus()

func _on_yes_pressed() -> void:
	if Global.file1:
		Progress.savedelete1()
		fileoptxt.visible = true
		loaddata.visible = true
		deletedata.visible = true
		areyousure.visible = false
		yes.visible = false
		no.visible = false
		fileoptions.visible = false
		file_1.visible = true
		file_2.visible = true
		file_3.visible = true
		nosave.visible = true
		back.visible = true
		pausebutton.visible = true
		Global.file1 = false
		Global.file2 = false
		Global.file3 = false
		$file1.grab_focus()
	if Global.file2:
		Progress.savedelete2()
		fileoptxt.visible = true
		loaddata.visible = true
		deletedata.visible = true
		areyousure.visible = false
		yes.visible = false
		no.visible = false
		fileoptions.visible = false
		file_1.visible = true
		file_2.visible = true
		file_3.visible = true
		nosave.visible = true
		back.visible = true
		pausebutton.visible = true
		Global.file1 = false
		Global.file2 = false
		Global.file3 = false
		$file1.grab_focus()
	if Global.file3:
		Progress.savedelete3()
		fileoptxt.visible = true
		loaddata.visible = true
		deletedata.visible = true
		areyousure.visible = false
		yes.visible = false
		no.visible = false
		fileoptions.visible = false
		file_1.visible = true
		file_2.visible = true
		file_3.visible = true
		nosave.visible = true
		back.visible = true
		pausebutton.visible = true
		Global.file1 = false
		Global.file2 = false
		Global.file3 = false
		$file1.grab_focus()
	



func _on_no_pressed() -> void:
	fileoptxt.visible = true
	loaddata.visible = true
	deletedata.visible = true
	back.visible = true
	areyousure.visible = false
	yes.visible = false
	no.visible = false
	$fileoptions/loaddata.grab_focus()


func _on_back_pressed() -> void:
	fileoptions.visible = false
	file_1.visible = true
	file_2.visible = true
	file_3.visible = true
	nosave.visible = true
	back.visible = true
	pausebutton.visible = true
	Global.file1 = false
	Global.file2 = false
	Global.file3 = false
	$file1.grab_focus()
