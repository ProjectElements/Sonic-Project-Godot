extends Node2D
@export var music: Node

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

func _ready() -> void:
	
	currentleveltimemin = 0
	currentleveltimesec = 0
	currentleveltimemili= 0
	ringssonichas = 0
	levelend = false
	

func _physics_process(delta: float) -> void:
	if Global.quit and Global.inlevel:
		Global.life100obt = false
		Global.sonicdied = false
		Global.gameover = false
		Global.currentlevelex = false
		Global.levelstarting = true
		Global.sonicsrings = 0
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		currentscore = 0
		GloBcheck.checkpoint1 = false
		GloBcheck.checkpoint2 = false
		GloBcheck.checkpoint3 = false
		GloBcheck.checkpoint4 = false
		GloBcheck.checkpoint5 = false
		Scenemanagement.levelselectscn = true
		Global.quit = false
		
	if !Global.life100obt and ringssonichas >= 100:
		Global.life100obt = true
		Global.lifeobtmusic = true
		Progress.lifecount += 1
	if Global.levelstarting and Global.currentlevelex and !Global.died:
		Global.levelfinished = false
		Global.levelclearscreen = false
		Global.isinendzone = false
		Global.signpostspun = false
		Global.sonicpassedsign = false
		levelend = false
		endoflev = false
		finalscore = 0
		currentscore = 0
		ringssonichas = 0
		scenenotswitched = true
		Global.pausedisabled = true
		await get_tree().create_timer(3.0).timeout
		Global.levelstarting = false
		Global.pausedisabled = false
	if Global.levelstarting and Global.currentlevelex and Global.died and !Global.timeover:
		Global.diedunderwater = false
		Global.levelfinished = false
		Global.levelclearscreen = false
		Global.isinendzone = false
		Global.signpostspun = false
		Global.sonicpassedsign = false
		levelend = false
		endoflev = false
		finalscore = 0
		currentscore = 0
		ringssonichas = 0
		scenenotswitched = true
		Global.pausedisabled = true
		await get_tree().create_timer(3.0).timeout
		Global.pausedisabled = false
		Global.levelstarting = false
		Global.died = false
	if Global.levelstarting and Global.currentlevelex and Global.died and Global.timeover:
		Global.diedunderwater = false
		Global.levelfinished = false
		Global.levelclearscreen = false
		Global.isinendzone = false
		Global.signpostspun = false
		Global.sonicpassedsign = false
		levelend = false
		endoflev = false
		finalscore = 0
		currentscore = 0
		ringssonichas = 0
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		scenenotswitched = true
		Global.pausedisabled = true
		await get_tree().create_timer(3.0).timeout
		Global.timeover = false
		Global.pausedisabled = false
		Global.levelstarting = false
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
	if Global.currentlevelex and !Global.gameover and !Global.levelstarting and !Global.signpostspun and !Global.levelfinished and !calculatefinalscore and !finalamountupdated and !endoflev and !levelend and !Global.pause:
		if currentleveltimemin < 15 and currentleveltimemili < 60:
			currentleveltimemili += 1
		elif currentleveltimemin < 15 and currentleveltimemili == 60:
			currentleveltimesec += 1
			currentleveltimemili = 0
		if currentleveltimemin < 15 and currentleveltimesec == 60:
			currentleveltimemin += 1
			currentleveltimesec = 0
	elif Global.signpostspun or Global.sonicdied or Global.levelfinished or Global.pause:
		currentleveltimesec = currentleveltimesec
		currentleveltimemin = currentleveltimemin
		currentleveltimemili = currentleveltimemili
	elif currentleveltimemin == 15 and !Global.levelstarting:
		currentleveltimemin = 15
		currentleveltimesec = 0
		currentleveltimemili= 0
	elif Global.levelstarting and !Global.died:
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0
	elif Global.levelstarting and Global.died:
		currentleveltimesec = currentleveltimesec
		currentleveltimemin = currentleveltimemin
		currentleveltimemili = currentleveltimemili
		ringssonichas = 0
	elif !Global.currentlevelex:
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0
	elif Global.gameover:
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0
		
		
#controls end of level scoring system
		
	if Global.levelclearscreen and !Global.levelstarting and scenenotswitched:
		Global.pausedisabled = true
		
		
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
			timebonus = 100
		
		await get_tree().create_timer(5.0).timeout
		if !calculatefinalscore and Global.levelclearscreen:
			calculatefinalscore = true
			Global.levelclearscreen = false
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
			Global.levelfinished = true
			levelend = true
			finalamountupdated = false
		if finalscore == finalamount and finalscore >= 100000:
			print("finalcalculatedpluslife")
			Progress.lifecount += 1
			Global.levelfinished = true
			levelend = true
			finalamountupdated = false
	if levelend and !endoflev:
		
		if currentleveltimemili < Progress.exlevelbesttimemili and currentleveltimesec == Progress.exlevelbesttimesec or currentleveltimemin < Progress.exlevelbesttimemin or currentleveltimesec < Progress.exlevelbesttimesec:
			Progress.exlevelbesttimemili = currentleveltimemili
			print(Progress.exlevelbesttimemili)
		if currentleveltimesec < Progress.exlevelbesttimesec and currentleveltimemin == Progress.exlevelbesttimemin or currentleveltimemin < Progress.exlevelbesttimemin:
			Progress.exlevelbesttimesec = currentleveltimesec
			print(Progress.exlevelbesttimesec)
		if currentleveltimemin < Progress.exlevelbesttimemin:
			Progress.exlevelbesttimemin = currentleveltimemin
			print(Progress.exlevelbesttimemin)
		
		elif !Progress.exlevelcleared:
			Progress.exlevelbesttimemin = currentleveltimemin
			Progress.exlevelbesttimesec = currentleveltimesec
			Progress.exlevelbesttimemili = currentleveltimemili
			
		if finalscore > Progress.exlevelscore:
			Progress.exlevelscore = finalscore
			
	if Global.levelfinished and levelend and !endoflev and finalscore < 100000:
		await get_tree().create_timer(2.0).timeout
		endoflev = true
		print("timerstart")
	if Global.levelfinished and levelend and !endoflev and finalscore >= 100000:
		await get_tree().create_timer(8.0).timeout
		endoflev = true
		print("timerstart")

	if endoflev and levelend:
		print("finaladjustment")
		Global.levelfinished = false
		Global.life100obt = false
		levelend = false
		endoflev = false
		GloBcheck.checkpoint1 = false
		GloBcheck.checkpoint2 = false
		GloBcheck.checkpoint3 = false
		GloBcheck.checkpoint4 = false
		GloBcheck.checkpoint5 = false
		Progress.exlevelcleared = 1
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
		Global.currentlevelex = false
		Global.levelstarting = true
		currentleveltimemin = 0
		currentleveltimesec = 0
		currentleveltimemili= 0
		ringssonichas = 0 
		Global.pausedisabled = false
		
		

func _on_gameover_music_finished() -> void:
	await get_tree().create_timer(2.0).timeout
	Global.life100obt = false
	Global.diedunderwater = false
	Global.sonicdied = false
	Global.gameover = false
	Global.currentlevelex = false
	Global.levelstarting = true
	Progress.lifecount = 3
	Global.sonicsrings = 0
	if Global.file1:
		Progress.save()
		Progress.load_data()
	if Global.file2:
		Progress.save2()
		Progress.load_2()
	if Global.file3:
		Progress.save3()
		Progress.load_3()
	currentleveltimemin = 0
	currentleveltimesec = 0
	currentleveltimemili= 0
	currentscore = 0
	GloBcheck.checkpoint1 = false
	GloBcheck.checkpoint2 = false
	GloBcheck.checkpoint3 = false
	GloBcheck.checkpoint4 = false
	GloBcheck.checkpoint5 = false
	Global.inlevel = false
	get_tree().change_scene_to_file("res://screens/level_select.tscn")


	
		


func _on_levelclear_music_finished() -> void:
	pass
