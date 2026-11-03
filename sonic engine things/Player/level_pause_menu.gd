extends CanvasLayer
@onready var back: Button = $back
@onready var quit: Button = $quit
@onready var setting: Button = $setting
@onready var settings: Control = $settings

var paused = false
var setmen = false


func _physics_process(delta: float):
	if Global.quit and !Global.inlevel:
		Scenemanagement.title = true
		Global.quit = false
	
	if Input.is_action_just_pressed("enter") and !Global.pausedisabled and !Global.gameover:
		paused = true			
			#egghammerfistdeal.disabled = true
		Global.pause = true
		$back.grab_focus()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if paused and !setmen:
		get_tree().paused = true
		visible = true
		back.disabled = false
		quit.disabled = false
		setting.disabled = false
		back.visible = true
		quit.visible = true
		setting.visible = true
		settings.visible = false
			
			
	if paused and setmen:
		get_tree().paused = true
		back.disabled = true
		quit.disabled = true
		setting.disabled = true
		back.visible = false
		quit.visible = false
		setting.visible = false
		settings.visible = true
		
		

func _on_back_pressed() -> void:
	#Engine.time_scale = 1.0
	get_tree().paused = false
	visible = false
	back.disabled = true
	quit.disabled = true
	paused = false
	Global.pause = false
	if !Global.inlevel:
		$"../Node/levelex".grab_focus()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_quit_pressed() -> void:
	get_tree().paused = false
	#Engine.time_scale = 1.0
	Global.quit = true
	back.disabled = true
	quit.disabled = true
	paused = false
	Global.pause = false

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Global.currentlevelbossex:
		Global.currentlevelbossex = false
		Global.bosslevelstart = true


func _on_settings_pressed() -> void:
	setmen = true
	$settings/return.grab_focus()


func _on_return_pressed() -> void:
	setmen = false
	$back.grab_focus()
