extends Node2D

##in this script, i provide a template for a boss level script you can feel free to copy and use for new levels
#all variables that need to be defined in this or another script will be denoted with an _

@export var music: Node

@onready var player: player = $Player
@onready var eggman_boss: RigidBody2D = $_
@onready var bossborders: Node2D = $bossborders


var ringssonichas
var livessonichas
var currentscore = 0
var currentleveltimemin = 0
var currentleveltimesec = 0
var currentleveltimemili = 0
var finalscore = 0
var timebonus = 0
var ringbonus = 0
var calculatefinalscore = false
var finalamount
var finalamountupdated = false
var ringbonuscalc
var finalleveltimemin = 0
var finalleveltimesec = 0
var finalleveltimemili = 0
var levelend = false
var soundeffectplaying = false
var scenenotswitched = true
var endoflev = false
@onready var raisetime: Timer = $musictimers/raisetime
@onready var explodetime: Timer = $musictimers/explodetime
@onready var finaltimer: Timer = $musictimers/finaltimer




@onready var bossraise: AudioStreamPlayer = $music/bossraise
@onready var bossdying: AudioStreamPlayer = $music/bossdying
@onready var bossfinal: AudioStreamPlayer = $music/bossfinal

func _ready() -> void:
	
	currentleveltimemin = 0
	currentleveltimesec = 0
	currentleveltimemili= 0
	ringssonichas = 0
	levelend = false
	

func _physics_process(delta: float):
	if Global.bosslevelstart and Global.currentlevelboss_ and !Global.died:
		Global.bosslevelfinished = false
		Global.bossclearscreen = false
		Global.bossdefeated = false
		levelend = false
		endoflev = false
		finalscore = 0
		currentscore = 0
		ringssonichas = 0
		scenenotswitched = true
		Global.pausedisabled = true
		await get_tree().create_timer(7.0).timeout
		Global.pausedisabled = false
		Global.bosslevelstart = false
	if Global.bosslevelstart and Global.currentlevelboss_ and Global.died:
		Global.bosslevelfinished = false
		Global.bossclearscreen = false
		Global.bossdefeated = false
		levelend = false
		endoflev = false
		finalscore = 0
		currentscore = 0
		ringssonichas = 0
		scenenotswitched = true
		Global.pausedisabled = true
		await get_tree().create_timer(7.0).timeout
		Global.bosslevelstart = false
		Global.pausedisabled = false
		Global.died = false
		
	livessonichas = Progress.lifecount
	
	ringssonichas = Global.sonicsrings
	if ringssonichas >= 1:	
		ringbonuscalc = ringssonichas * 100
	elif ringssonichas == 0:
		ringbonuscalc = 0

	if Global.sonicdied:
		currentscore = 0
		
	if Global.pause or !Global.currentlevelboss_:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Global.currentlevelboss_ and !Global.pause:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
#CONTROLS LEVEL TIMER
	if Global.currentlevelboss_ and !Global.gameover and !Global.bosslevelstart and !Global.bossdefeated and !Global.egg_bossdefeated and !Global.bosslevelfinished and !calculatefinalscore and !finalamountupdated and !endoflev and !levelend and !Global.bossclearscreen and !Global.pause:
		if currentleveltimemili < 60:
			currentleveltimemili += 1
		elif currentleveltimemili == 60:
			currentleveltimesec += 1
			currentleveltimemili = 0
		if currentleveltimesec == 60:
			currentleveltimemin += 1
			currentleveltimesec = 0
	elif Global.bossdefeated or Global.sonicdied or Global.bosslevelfinished or Global.bossclearscreen or Global.egg_bossdefeated or Global.pause: 
		currentleveltimesec = currentleveltimesec
		currentleveltimemin = currentleveltimemin
		currentleveltimemili = currentleveltimemili
	
	elif Global.bosslevelstart and !Global.died:
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0
	elif Global.bosslevelstart and Global.died:
		currentleveltimesec = currentleveltimesec
		currentleveltimemin = currentleveltimemin
		currentleveltimemili = currentleveltimemili
		ringssonichas = 0
	elif !Global.currentlevelboss_:
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0
	elif Global.gameover:
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0
		

	
		
		
		
#controls end of level scoring systemm
	
	if Global.bossdefeated and !Global.bossclearscreen and !Global.bosslevelstart:
		Global.bossdyingsfx = true
		Global.bossdefeated = false
		
		Global.calculatingfinalscore = true
		await get_tree().create_timer(12.0).timeout
		Global.bossclearscreen = true
		
		
	if Global.bossclearscreen and !Global.bosslevelstart and scenenotswitched and !Global.bossdefeated:
		
		
		
		if !calculatefinalscore:
			ringbonus = ringbonuscalc
		if !calculatefinalscore:
			finalscore = currentscore
		if !calculatefinalscore and currentleveltimemin < 1:
			timebonus = 50000
		if !calculatefinalscore and currentleveltimemin == 1 and currentleveltimemin < 2:
			timebonus = 30000
		if !calculatefinalscore and currentleveltimemin >=2 and currentleveltimemin < 5:
			timebonus = 10000
		if !calculatefinalscore and currentleveltimemin >=5 and currentleveltimemin < 15:
			timebonus = 1000
		
		await get_tree().create_timer(5.0).timeout
		if !calculatefinalscore and Global.bossclearscreen:
			calculatefinalscore = true
			Global.bossclearscreen = false
			
			print("calculatingfinal")
	if calculatefinalscore:
		if !finalamountupdated and ringbonus > 0:
			finalamount = finalscore + timebonus + ringbonus
			finalamountupdated = true
			calculatefinalscore = false
		elif !finalamountupdated and ringbonus == 0:
			finalamount = finalscore + timebonus
			finalamountupdated = true
			calculatefinalscore = false
	if finalamountupdated:
		if finalscore < finalamount:
			finalscore += 100		
		if timebonus > 0:
			timebonus -= 100
		if timebonus == 0:
			timebonus == 0
		if ringbonus > 0:
			ringbonus -= 100		
		if finalscore == finalamount and finalscore < 100000:
			print("finalcalculated")
			Global.bosslevelfinished = true
			Global.calculatingfinalscore = false
			levelend = true
			finalamountupdated = false
		if finalscore == finalamount and finalscore >= 100000:
			print("finalcalculatedpluslife")
			Progress.lifecount += 1
			Global.bosslevelfinished = true
			Global.calculatingfinalscore = false
			levelend = true
			finalamountupdated = false
	if levelend and !endoflev:
		
		if currentleveltimemili < Progress._bossbesttimemili and currentleveltimesec == Progress._bossbesttimesec or currentleveltimemin < Progress._bossbesttimemin or currentleveltimesec < Progress._bossbesttimesec:
			Progress._bossbesttimemili = currentleveltimemili
			print(Progress._bossbesttimemili)
		if currentleveltimesec < Progress._bossbesttimesec and currentleveltimemin == Progress._bossbesttimemin or currentleveltimemin < Progress._bossbesttimemin:
			Progress._bossbesttimesec = currentleveltimesec
			print(Progress._bossbesttimesec)
		if currentleveltimemin < Progress._bossbesttimemin:
			Progress._bossbesttimemin = currentleveltimemin
			print(Progress._bossbesttimemin)
		
		if !Progress._bosscleared:
			Progress._bossbesttimemin = currentleveltimemin
			Progress._bossbesttimesec = currentleveltimesec
			Progress._bossbesttimemili = currentleveltimemili
			
		if finalscore > Progress._bossscore:
			Progress._bossscore = finalscore
			
	if Global.bosslevelfinished and levelend and !endoflev and finalscore < 100000:
		await get_tree().create_timer(2.0).timeout
		endoflev = true
		print("timerstart")
	if Global.bosslevelfinished and levelend and !endoflev and finalscore >= 100000:
		await get_tree().create_timer(8.0).timeout
		endoflev = true
		print("timerstart")

	if endoflev and levelend:
		print("finaladjustment")
		Global.bosslevelfinished = false
		Global.bossclearscreen = false
		Global.pausedisabled = false
		levelend = false
		endoflev = false
		Progress._bosscleared = 1
		if Global.file1:
			Progress.save()
			Progress.load_data()
		if Global.file2:
			Progress.save2()
			Progress.load_2()
		if Global.file3:
			Progress.save3()
			Progress.load_3()
		Scenemanagement.levelselectscn = true
		Global.currentlevelboss_ = false
		Global.bosslevelstart = true
		Global.egg_bossdefeated = false
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0 
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and !Global.bossdefeated and !Global.bossclearscreen and !Global.bosslevelfinished and !Global.calculatingfinalscore:
		player.global_position.x -= 8750
		eggman_boss.global_position.x -= 8750
		bossborders.global_position.x -= 8750



func _on_gameover_finished() -> void:
	await get_tree().create_timer(2.0).timeout
	Global.sonicdied = false
	Global.gameover = false
	Global.currentlevelboss_ = false
	Global.bosslevelstart = true
	Global.lifecount = 3
	Global.sonicsrings = 0
	currentleveltimemin = 0
	currentleveltimesec = 0
	currentleveltimemili= 0
	currentscore = 0
	get_tree().change_scene_to_file("res://screens/level_select.tscn")


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerdeal"):
		player.global_position.x -= 8750
		eggman_boss.global_position.x -= 8750
		bossborders.global_position.x -= 8750
