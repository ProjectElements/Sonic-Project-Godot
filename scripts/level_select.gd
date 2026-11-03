extends Node2D
@onready var levelstats: CanvasLayer = $levelstats
@onready var pause_menu: CanvasLayer = $"pause menu"
@onready var back: Button = $"pause menu/Back"
@onready var quit: Button = $"pause menu/Quit"
@onready var settings: Button = $"pause menu/settings"
@onready var settingmenu: CanvasLayer = $settingmenu
@onready var bosslevelex: Button = $Node/bosslevelex
@onready var levelex: Button = $Node/levelex
@onready var camera: Camera2D = $Camera2D
@onready var expos: Node2D = $Node/levelex/expos
@onready var bossexpos: Node2D = $Node/bosslevelex/bossexpos



var levelexstats = false
var levelbossexstats = false
var paused = false
var setmen = false

func _ready() -> void:
	$Node/levelex.grab_focus()

func _process(delta: float):
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	#if Input.is_action_just_pressed("enter"):
	#	paused = true
	
		
		
	#if paused and !setmen:
		#Engine.time_scale = 0.0
		
	#	get_tree().paused = true
	#	pause_menu.visible = true
	#	settings.disabled = false
	#	back.disabled = false
	#	quit.disabled = false
	#	settingmenu.visible = false
		
	#elif paused and setmen:
		#Engine.time_scale = 0.0
	#	get_tree().paused = true
	#	pause_menu.visible = false
	#	settingmenu.visible = true
		
	
	
		
	levelprogression()
	updatelevelclear()
	updateleveltime()
	updatelevelscore()

func levelprogression():
	if Progress.exlevelcleared:
		bosslevelex.disabled = false

func updatelevelclear():
	if levelexstats and !levelbossexstats and Progress.exlevelcleared == 1:
		$levelstats/levelclear.text = ("cleared")
	if levelbossexstats and !levelexstats and Progress.exbosscleared == 1:
		$levelstats/levelclear.text = ("cleared")
	elif !Progress.exlevelcleared == 1 and levelexstats or !Progress.exbosscleared == 1 and levelbossexstats:
		$levelstats/levelclear.text = ("not cleared")

func updatelevelscore():
	if levelexstats:
		$levelstats/levelscore.text = str(Progress.exlevelscore)
	if levelbossexstats:
		$levelstats/levelscore.text = str(Progress.exbossscore)

func updateleveltime():
	if levelexstats:
		$levelstats/leveltimemin.text = str(Progress.exlevelbesttimemin)
		$levelstats/leveltimesec.text = str(Progress.exlevelbesttimesec)
		$levelstats/leveltimemili.text = str(Progress.exlevelbesttimemili)
	if levelbossexstats:
		$levelstats/leveltimemin.text = str(Progress.exbossbesttimemin)
		$levelstats/leveltimesec.text = str(Progress.exbossbesttimesec)
		$levelstats/leveltimemili.text = str(Progress.exbossbesttimemili)

func _on_levelex_mouse_entered() -> void:
	levelstats.visible = true
	levelexstats = true
	levelbossexstats = false
	#camera.global_position = expos.global_position
	




	

func _on_levelex_mouse_exited() -> void:
	levelstats.visible = false
	levelexstats = false


func _on_levelex_pressed() -> void:
	Global.currentlevelex = true
	Global.levelstarting = true
	Global.bosslevelstart = false
	Scenemanagement.levelex = true
	Global.inlevel = true
	


func _on_bosslevelex_mouse_entered() -> void:
	levelstats.visible = true
	levelbossexstats = true
	levelexstats = false
	#camera.global_position = bossexpos.global_position


func _on_bosslevelex_mouse_exited() -> void:
	levelstats.visible = false
	levelbossexstats = false
	

func _on_bosslevelex_pressed() -> void:
	Global.currentlevelbossex = true
	Global.levelstarting = false
	Global.bosslevelstart = true
	Scenemanagement.levelbossex = true
	Global.inlevel = true



func _on_back_pressed() -> void:
	#Engine.time_scale = 1.0
	get_tree().paused = false
	pause_menu.visible = false
	back.disabled = true
	settings.disabled = true
	quit.disabled = true
	paused = false


func _on_quit_pressed() -> void:
	#Engine.time_scale = 1.0
	get_tree().paused = false
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
	paused = false
	
	


func _on_settings_pressed() -> void:
	setmen = true
	


func _on_return_pressed() -> void:
	setmen = false


func _on_levelex_focus_entered() -> void:
	levelstats.visible = true
	levelexstats = true
	levelbossexstats = false


func _on_bosslevelex_focus_entered() -> void:
	levelstats.visible = true
	levelbossexstats = true
	levelexstats = false


func _on_levelex_focus_exited() -> void:
	levelstats.visible = false
	levelexstats = false


func _on_bosslevelex_focus_exited() -> void:
	levelstats.visible = false
	levelbossexstats = false
