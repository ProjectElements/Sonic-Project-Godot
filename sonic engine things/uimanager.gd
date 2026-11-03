extends CanvasLayer
var currentlevel

func _process(delta: float):
	update_ring_display()
	update_life_display()
	update_score_display()
	update_time_min()
	update_time_sec()
	update_time_mili()
	scoretally()
	updateact()
	if Global.gameover: #if gameover
		await get_tree().create_timer(1.0).timeout #and the timer runs out
		$gameovertxt.visible = true #makes the gameover text visible
		$rings.visible = false #and the rest of the UI invisible
		$ringdisplay.visible = false
		$lifetex.visible = false
		$lifedisplay.visible = false
		$time.visible = false
		$time2.visible = false
		$timedisplaymin.visible = false
		$timedisplaysec.visible = false
		$timedisplaymil.visible = false
		$score.visible = false
		$scoredisplay.visible = false
		
		
	if Global.levelclearscreen or Global.bossclearscreen:
		$sonichaspassedtxt.visible = true
		$actdisplay.visible = true
		$timebonusdisplay.visible = true
		$ringbonusdisplay.visible = true
		$finalscoredisplay.visible = true
		$timebonus.visible = true
		$ringbonus.visible = true
		$finalscore.visible = true
	
	if Global.currentlevelex:	
		if Global.levelfinished and Levelscriptex.finalscore < 100000:
			await get_tree().create_timer(1.9).timeout
			$sonichaspassedtxt.visible = false
			$actdisplay.visible = false
			$timebonusdisplay.visible = false
			$ringbonusdisplay.visible = false
			$finalscoredisplay.visible = false
			$timebonus.visible = false
			$ringbonus.visible = false
			$finalscore.visible = false
		if Global.levelfinished and Levelscriptex.finalscore >= 100000:
			
			await get_tree().create_timer(6.9).timeout
			$sonichaspassedtxt.visible = false
			$actdisplay.visible = false
			$timebonusdisplay.visible = false
			$ringbonusdisplay.visible = false
			$finalscoredisplay.visible = false
			$timebonus.visible = false
			$ringbonus.visible = false
			$finalscore.visible = false
	if Global.currentlevelbossex:	
		if Global.levelfinished and Exampleboss.finalscore < 100000:
			await get_tree().create_timer(1.9).timeout
			$sonichaspassedtxt.visible = false
			$actdisplay.visible = false
			$timebonusdisplay.visible = false
			$ringbonusdisplay.visible = false
			$finalscoredisplay.visible = false
			$timebonus.visible = false
			$ringbonus.visible = false
			$finalscore.visible = false
	

func scoretally():
	if Global.currentlevelex:
		$timebonusdisplay.text = str(Levelscriptex.timebonus)
		$ringbonusdisplay.text = str(Levelscriptex.ringbonus)
		$finalscoredisplay.text = str(Levelscriptex.finalscore)
	if Global.currentlevelbossex:
		$timebonusdisplay.text = str(Exampleboss.timebonus)
		$ringbonusdisplay.text = str(Exampleboss.ringbonus)
		$finalscoredisplay.text = str(Exampleboss.finalscore)
	
func updateact():
	if Global.currentlevelex:
		$actdisplay.text = ("EX")
	if Global.currentlevelbossex:
		$actdisplay.text = ("BOSS")
func update_time_min():
	if Global.currentlevelex:
		$timedisplaymin.text = str(Levelscriptex.currentleveltimemin)
	if Global.currentlevelbossex:
		$timedisplaymin.text = str(Exampleboss.currentleveltimemin)
func update_time_sec():
	if Global.currentlevelex:
		$timedisplaysec.text = str(Levelscriptex.currentleveltimesec)
	if Global.currentlevelbossex:
		$timedisplaysec.text = str(Exampleboss.currentleveltimesec)
		
func update_time_mili():
	if Global.currentlevelex:
		$timedisplaymil.text = str(Levelscriptex.currentleveltimemili)
	if Global.currentlevelbossex:
		$timedisplaymil.text = str(Exampleboss.currentleveltimemili)	
func update_score_display():
	if Global.currentlevelex:
		$scoredisplay.text = str(Levelscriptex.currentscore)
	if Global.currentlevelbossex:
		$scoredisplay.text = str(Exampleboss.currentscore)
func update_ring_display():
	if Global.currentlevelex:
		$ringdisplay.text = str(Levelscriptex.ringssonichas) #updates the rings you have
	if Global.currentlevelbossex:
		$ringdisplay.text = str(Exampleboss.ringssonichas)
func update_life_display():
	$lifedisplay.text = str(Progress.lifecount) #updates the lives you have
