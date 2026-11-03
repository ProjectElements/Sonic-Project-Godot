extends Node

var sonicsrings = 0
var lifecount = 3
var sonicdied = false
var gameover = false
var levelfinished = false
var sonicpassedsign = false
var levelclearscreen = false
var isinendzone = false
var signpostspun = false
var levelstarting = true
var bosslevelstart = true
var bossdefeated = false
var bossclearscreen = false
var bosslevelfinished = false
var bosspinch = false
var calculatingfinalscore = false
var egghammerbossdefeated = false
var died = false
var quit = false
var pausedisabled = false
var pause = false
var isunderwater = false
var drownmusic = false
var diedunderwater = false
var timeover = false
var bossdyingsfx = false
var bossraisesfx = false
var whitescreen = false
var life100obt = false
var lifeobtmusic = false

var inlevel = false

#current save file
var file1 = false
var file2 = false
var file3 = false

#current levels
var currentlevelex = false
var currentlevelbossex = false


func _input(event):
	if event.is_action_pressed("refresh"):
		get_tree().reload_current_scene()
	
	if event.is_action_pressed("esc"):
		get_tree().quit()
		
