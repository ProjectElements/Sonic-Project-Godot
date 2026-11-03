extends Control

@onready var musvolumes: HSlider = $MarginContainer/VBoxContainer/musvolume
@onready var sfxvolumes: HSlider = $MarginContainer/VBoxContainer/sfxvolume
@onready var frames: HSlider = $MarginContainer/VBoxContainer/framerate
@onready var fpscount: Label = $MarginContainer/VBoxContainer/fpscount
@onready var v_synccheck: CheckBox = $"MarginContainer/VBoxContainer/v-synccheck"
@onready var fullscheck: CheckBox = $MarginContainer/VBoxContainer/fullscheck
@onready var framerate: HSlider = $MarginContainer/VBoxContainer/framerate


@export var audio_bus_name_mus: String
@export var audio_bus_name_sfx: String
var audio_bus_id_mus
var audio_bus_id_sfx
func _ready() -> void:
	audio_bus_id_mus = AudioServer.get_bus_index(audio_bus_name_mus)
	audio_bus_id_sfx = AudioServer.get_bus_index(audio_bus_name_sfx)
	
	
	var video_settings = Configfile.load_video_settings()
	frames.value = min(video_settings.framerate , 1000)
	fullscheck.button_pressed = video_settings.fullscreen
	v_synccheck.button_pressed = video_settings.vsync
	
	var audio_settings = Configfile.load_audio_settings()
	musvolumes.value = min(audio_settings.music , 1.0)
	sfxvolumes.value = min(audio_settings.sfx , 1.0)

func _process(delta: float) -> void:
	if frames.value > 0:
		fpscount.text = str(frames.value)
	elif frames.value == 0:
		fpscount.text = "uncapped"
	

func _on_volume_value_changed(value: float) -> void:
	var dbm = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id_mus, dbm)
	Configfile.save_audio_setting("music", musvolumes.value)


func _on_sfxvolume_value_changed(value: float) -> void:
	var dbs = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id_sfx, dbs)
	Configfile.save_audio_setting("sfx", sfxvolumes.value)


func _on_musvolume_drag_ended(value_changed: bool) -> void:
	if value_changed:
		Configfile.save_audio_setting("music", musvolumes.value)


func _on_sfxvolume_drag_ended(value_changed: bool) -> void:
	if value_changed:	
		Configfile.save_audio_setting("sfx", sfxvolumes.value)


func _on_vsynccheck_toggled(toggled_on: bool) -> void:
	Configfile.save_video_setting("vsync", toggled_on)
	if toggled_on == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

func _on_fullscheck_toggled(toggled_on: bool) -> void:
	Configfile.save_video_setting("fullscreen", toggled_on)
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_framerate_value_changed(value: float) -> void:
	Engine.max_fps = frames.value
	Configfile.save_video_setting("framerate", frames.value)


func _on_framerate_drag_ended(value_changed: bool) -> void:
	if value_changed:	
		Configfile.save_video_setting("framerate", frames.value)
