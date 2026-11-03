extends CanvasLayer
@onready var levelexstarttext: Label = $startscreentext/levelexstarttext
@onready var bossexstarttext: Label = $startscreentext/bossexstarttext

@onready var startscreenbg: TextureRect = $startscreenbg
@onready var startscreenbg_2: TextureRect = $startscreenbg2
var levelstarted = false
var start = true
var mid = false
var end = false
func _ready() -> void:
	bossexstarttext.visible = false
	levelexstarttext.visible = false

func _physics_process(delta: float):
	if Global.levelstarting and !levelstarted:
		levelstarted = true
		levelexstarttext.global_position.x = -1296
		bossexstarttext.global_position.x = -1296
		startscreenbg_2.global_position.y = -816
	if Global.currentlevelex and levelstarted:	
		levelexstarttext.visible = true
		
	if Global.bosslevelstart and !levelstarted:
		levelstarted = true
		levelexstarttext.global_position.x = -1296
		bossexstarttext.global_position.x = -1296
		startscreenbg_2.global_position.y = -816
	if Global.currentlevelbossex and levelstarted:
		bossexstarttext.visible = true
		
	if levelstarted and Global.currentlevelex:
		if start and levelexstarttext.global_position.x < 24:
			levelexstarttext.global_position.x += 30
		if start and startscreenbg_2.global_position.y < -4:
			startscreenbg_2.global_position.y += 24
		elif start and startscreenbg_2.global_position.y >= -4  and levelexstarttext.global_position.x >= 24:
			start = false
			print("timerstart")
			$levelbegin.start()
			
		if !start and mid:
			startscreenbg.visible = false
			
			mid = false
			$levelshown.start()
			
		if end and levelexstarttext.global_position.x < 1328:
			levelexstarttext.global_position.x += 100
		if end and startscreenbg_2.global_position.y < 792:
			startscreenbg_2.global_position.y += 100
		if end and startscreenbg_2.global_position.y >= 792  and levelexstarttext.global_position.y >= 1328:	
			end = false
			levelstarted = false	
			
		#await get_tree().create_timer(2.0).timeout
		#startscreenbg.visible = false
		
		#startscreenbg_2.visible = false
		#if Global.currentlevelex:
		#	levelexstarttext.visible = false
		#levelstarted = false
	
	if levelstarted and Global.currentlevelbossex:
		if start and bossexstarttext.global_position.x < 24:
			bossexstarttext.global_position.x += 30
		if start and startscreenbg_2.global_position.y < -4:
			startscreenbg_2.global_position.y += 24
		elif start and startscreenbg_2.global_position.y >= -4  and bossexstarttext.global_position.x >= 24:
			start = false
			print("timerstart")
			$levelbegin.start()
			
		if !start and mid:
			startscreenbg.visible = false
			
			mid = false
			$levelshown.start()
			
		if end and bossexstarttext.global_position.x < 1328:
			bossexstarttext.global_position.x += 100
		if end and startscreenbg_2.global_position.y < 792:
			startscreenbg_2.global_position.y += 100
		if end and startscreenbg_2.global_position.y >= 792  and bossexstarttext.global_position.y >= 1328:	
			end = false
			levelstarted = false


func _on_levelbegin_timeout() -> void:
	mid = true

func _on_levelshown_timeout() -> void:
	end = true
