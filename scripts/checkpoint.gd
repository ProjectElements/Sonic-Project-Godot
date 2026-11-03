extends Area2D
var speen = false
var hasnt = true
@export var check1 = false
@export var check2 = false
@export var check3 = false
@export var check4 = false
@export var check5 = false
@onready var top: AnimatedSprite2D = $top
@onready var checksound: AudioStreamPlayer = $checksound

func _physics_process(delta: float) -> void:
	if speen and hasnt and top.rotation_degrees < 360:
		top.rotation_degrees += 10
		
	if speen and hasnt and top.rotation_degrees == 360:
		hasnt = false
	if Global.levelstarting and GloBcheck.checkpoint1 and check1:
		top.play("crossed")
		hasnt = false
	if Global.levelstarting and GloBcheck.checkpoint2 and check2:
		top.play("crossed")
		hasnt = false
	if Global.levelstarting and GloBcheck.checkpoint3 and check3:
		top.play("crossed")
		hasnt = false
	if Global.levelstarting and GloBcheck.checkpoint4 and check4:
		top.play("crossed")
		hasnt = false
	if Global.levelstarting and GloBcheck.checkpoint5 and check5:
		top.play("crossed")
		hasnt = false
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and !speen :
		speen = true
		top.play("crossed")
		checksound.play()
		if check1:
			GloBcheck.checkpoint1 = true
			GloBcheck.checkpoint2 = false
			GloBcheck.checkpoint3 = false
			GloBcheck.checkpoint4 = false
			GloBcheck.checkpoint5 = false
		if check2:
			GloBcheck.checkpoint1 = false
			GloBcheck.checkpoint2 = true
			GloBcheck.checkpoint3 = false
			GloBcheck.checkpoint4 = false
			GloBcheck.checkpoint5 = false
		if check3:
			GloBcheck.checkpoint1 = false
			GloBcheck.checkpoint2 = false
			GloBcheck.checkpoint3 = true
			GloBcheck.checkpoint4 = false
			GloBcheck.checkpoint5 = false
		if check4:
			GloBcheck.checkpoint1 = false
			GloBcheck.checkpoint2 = false
			GloBcheck.checkpoint3 = false
			GloBcheck.checkpoint4 = true
			GloBcheck.checkpoint5 = false
		if check5:
			GloBcheck.checkpoint1 = false
			GloBcheck.checkpoint2 = false
			GloBcheck.checkpoint3 = false
			GloBcheck.checkpoint4 = false
			GloBcheck.checkpoint5 = true
