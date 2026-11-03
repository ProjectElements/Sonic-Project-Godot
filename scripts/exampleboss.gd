extends Node2D

@export var music: Node

@onready var player: player = $Player
@onready var eggmanhammerboss: RigidBody2D = $eggmanhammerboss
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
	if Global.bosslevelstart and Global.currentlevelbossex and !Global.died:
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
	if Global.bosslevelstart and Global.currentlevelbossex and Global.died:
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
		
		
	
	
#CONTROLS LEVEL TIMER
	if Global.currentlevelbossex and !Global.gameover and !Global.bosslevelstart and !Global.bossdefeated and !Global.egghammerbossdefeated and !Global.bosslevelfinished and !calculatefinalscore and !finalamountupdated and !endoflev and !levelend and !Global.bossclearscreen and !Global.pause:
		if currentleveltimemili < 60:
			currentleveltimemili += 1
		elif currentleveltimemili == 60:
			currentleveltimesec += 1
			currentleveltimemili = 0
		if currentleveltimesec == 60:
			currentleveltimemin += 1
			currentleveltimesec = 0
	elif Global.bossdefeated or Global.sonicdied or Global.bosslevelfinished or Global.bossclearscreen or Global.egghammerbossdefeated or Global.pause: 
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
	elif !Global.currentlevelbossex:
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
		
		if currentleveltimemili < Progress.exbossbesttimemili and currentleveltimesec == Progress.exbossbesttimesec or currentleveltimemin < Progress.exbossbesttimemin or currentleveltimesec < Progress.exbossbesttimesec:
			Progress.exbossbesttimemili = currentleveltimemili
			print(Progress.exbossbesttimemili)
		if currentleveltimesec < Progress.exbossbesttimesec and currentleveltimemin == Progress.exbossbesttimemin or currentleveltimemin < Progress.exbossbesttimemin:
			Progress.exbossbesttimesec = currentleveltimesec
			print(Progress.exbossbesttimesec)
		if currentleveltimemin < Progress.exbossbesttimemin:
			Progress.exbossbesttimemin = currentleveltimemin
			print(Progress.exbossbesttimemin)
		
		if !Progress.exbosscleared:
			Progress.exbossbesttimemin = currentleveltimemin
			Progress.exbossbesttimesec = currentleveltimesec
			Progress.exbossbesttimemili = currentleveltimemili
			
		if finalscore > Progress.exbossscore:
			Progress.exbossscore = finalscore
			
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
		if Progress.exbosscleared == 0:
			Scenemanagement.end = true
			Global.inlevel = false
		if Progress.exbosscleared == 1:
			Scenemanagement.levelselectscn = true
		Progress.exbosscleared = 1
		if Global.file1:
			Progress.save()
			Progress.load_data()
		if Global.file2:
			Progress.save2()
			Progress.load_2()
		if Global.file3:
			Progress.save3()
			Progress.load_3()
		
		Global.currentlevelbossex = false
		Global.bosslevelstart = true
		Global.egghammerbossdefeated = false
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0 
		

		

func _on_gameover_music_finished() -> void:
	pass

	
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and !Global.bossdefeated and !Global.bossclearscreen and !Global.bosslevelfinished and !Global.calculatingfinalscore:
		player.global_position.x -= 8750
		eggmanhammerboss.global_position.x -= 8750
		bossborders.global_position.x -= 8750
	#elif area.is_in_group("playerdeal") and Global.bossdefeated or area.is_in_group("playerdeal") and Global.bossclearscreen or area.is_in_group("playerdeal") and Global.bosslevelfinished or area.is_in_group("playerdeal") and Global.calculatingfinalscore:
	#	player.global_position.x -= 8750
	#	eggmanhammerboss.global_position.x -= 8750
	#	bossborders.global_position.x -= 8750


func _on_levelendsfx_finished() -> void:
	pass # Replace with function body.


func _on_gameover_finished() -> void:
	await get_tree().create_timer(2.0).timeout
	Global.sonicdied = false
	Global.gameover = false
	Global.currentlevelbossex = false
	Global.bosslevelstart = true
	Global.lifecount = 3
	Global.sonicsrings = 0
	currentleveltimemin = 0
	currentleveltimesec = 0
	currentleveltimemili= 0
	currentscore = 0
	Global.inlevel = false
	get_tree().change_scene_to_file("res://screens/level_select.tscn")


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerdeal"):
		player.global_position.x -= 8750
		eggmanhammerboss.global_position.x -= 8750
		bossborders.global_position.x -= 8750
