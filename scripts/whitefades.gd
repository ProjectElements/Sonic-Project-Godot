extends CanvasLayer

@onready var sprite_2d: Sprite2D = $Sprite2D
var isvisible = false
func _physics_process(delta: float) -> void:
	if Global.whitescreen:
		visible = true
		Global.whitescreen = false
		await get_tree().create_timer(2.0).timeout
		isvisible = true
		
	if isvisible:
		sprite_2d.self_modulate.a -= 0.01
	
