extends Node2D
@onready var icon: Sprite2D = $Icon
@onready var advance_3_sonic: Sprite2D = $Advance3Sonic
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var play: Button = $play
@onready var button: Button = $Button
@onready var quit: Button = $quit
@onready var blackbackground: Sprite2D = $blackbackground

var showtitlescreen = false
var titlescreenvisible = false

@onready var sonic_1: Sprite2D = $animsprites/sonic1
@onready var godot_1: Sprite2D = $animsprites/godot1

var sonic1notvis = true
var sonic1vis = false

var godot1notvis = false
var godot1vis = false

var bothnotvis = false
var bothvis = false

@onready var sonic_2: Sprite2D = $animsprites/sonic2
@onready var godot_2: Sprite2D = $animsprites/godot2


var sonic2notatpos = false
var godot2notatpos = false

@onready var godot_3: Sprite2D = $animsprites/godot3
@onready var sonic_3: Sprite2D = $animsprites/sonic3
@onready var whitefade: Sprite2D = $animsprites/whitefade


var bothnotatpos = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !titlescreenvisible:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	if Input.is_action_just_pressed("jump") and !titlescreenvisible:
		showtitlescreen = true
	if showtitlescreen:
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		sonic_1.visible = false
		godot_1.visible = false
		sonic_2.visible = false
		godot_2.visible = false
		sonic_3.visible = false
		godot_3.visible = false
		whitefade.visible = false
		blackbackground.visible = false
		icon.visible = true
		advance_3_sonic.visible = true
		sprite_2d_2.visible = true
		label.visible = true
		label_2.visible = true
		play.visible = true
		button.visible = true
		quit.visible = true
		titlescreenvisible = true
		showtitlescreen = false
		$play.grab_focus()
	titleanimation()
	
func titleanimation():
	if !showtitlescreen:
		if sonic_1.self_modulate.a < 1 and sonic1notvis:
			sonic_1.self_modulate.a += 0.05
		if sonic_1.self_modulate.a >= 1 and sonic1notvis:
			await get_tree().create_timer(1.0).timeout
			sonic1notvis = false
			sonic1vis = true
			
		if sonic1vis and sonic_1.self_modulate.a > 0:
			sonic_1.self_modulate.a += -0.05
		if sonic1vis and sonic_1.self_modulate.a <= 0:
			sonic1vis = false
			godot1notvis = true
			
		if godot_1.self_modulate.a < 1 and godot1notvis:
			godot_1.self_modulate.a += 0.05
		if godot_1.self_modulate.a >= 1 and godot1notvis:
			await get_tree().create_timer(1.0).timeout
			godot1notvis = false
			godot1vis = true
			
		if godot1vis and godot_1.self_modulate.a > 0:
			godot_1.self_modulate.a += -0.05
		if godot1vis and godot_1.self_modulate.a <= 0:
			godot1vis = false
			bothnotvis = true
			
		if bothnotvis and sonic_1.self_modulate.a < 1:
			sonic_1.self_modulate.a += 0.05
			
			
		if bothnotvis and godot_1.self_modulate.a < 1:	
			godot_1.self_modulate.a += 0.5
			
			
		if sonic_1.self_modulate.a >= 1 and bothnotvis:
			await get_tree().create_timer(1.0).timeout	
			bothnotvis = false
			bothvis = true
		
		if bothvis and godot_1.self_modulate.a > 0:
			godot_1.self_modulate.a += -0.05
			
		if bothvis and sonic_1.self_modulate.a > 0:
			sonic_1.self_modulate.a += -0.05
		if bothvis and godot_1.self_modulate.a <= 0 and sonic_1.self_modulate.a <= 0:
			bothvis = false	
			sonic2notatpos = true
			
		if sonic2notatpos and sonic_2.global_position.x < 1536:
			sonic_2.global_position.x += 10
			
		if sonic2notatpos and sonic_2.global_position.x >= 1536:
			sonic2notatpos = false
			godot2notatpos = true
			
		if godot2notatpos and godot_2.global_position.x > -256:
			godot_2.global_position.x -= 22
			
		if godot2notatpos and godot_2.global_position.x <= -256:
			godot2notatpos = false
			bothnotatpos = true
			
		if bothnotatpos and godot_3.global_position.x < 736:
			godot_3.global_position.x += 15
		
		if bothnotatpos and sonic_3.global_position.x > 504:
			sonic_3.global_position.x -= 15
			
		if bothnotatpos and whitefade.self_modulate.a < 1:
			whitefade.self_modulate.a += 0.014

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/save_screen.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/optionsmenu.tscn")


func _on_titledrop_timeout() -> void:
	showtitlescreen = true
	
