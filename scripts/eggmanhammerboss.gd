extends Node2D
@onready var chain_1: RigidBody2D = $eggmobileparts/chainsback/egghammer/chain1
@onready var chain_2: RigidBody2D = $eggmobileparts/chainsback/chain2

@onready var chain_3: RigidBody2D = $eggmobileparts/chainsback/chain3
@onready var chain_5: RigidBody2D = $eggmobileparts/chainsback/chain5
@onready var chain_6: RigidBody2D = $eggmobileparts/chainsback/chain6
@onready var chain_7: RigidBody2D = $eggmobileparts/chainsback/chain7
@onready var eggmantakedamagebox: Area2D = $eggmobileparts/egghammerbody/eggmantakedamagebox


@onready var collision_polygon_2d: CollisionPolygon2D = $eggmobileparts/egghammerbody/eggmantakedamagebox/CollisionPolygon2D
@onready var egghammerfistdeal: CollisionShape2D = $eggmobileparts/egghammerfist/eggmandealdamage/egghammerfistdeal
@onready var egghammerbackwheels: RigidBody2D = $eggmobileparts/egghammerbackwheels
@onready var egghammerbackwheels_2: RigidBody2D = $eggmobileparts/egghammerbackwheels2
@onready var egghammerbody: RigidBody2D = $eggmobileparts/egghammerbody
@onready var egghammerfrontwheels: RigidBody2D = $eggmobileparts/egghammerfrontwheels
@onready var egghammerfrontwheels_2: RigidBody2D = $eggmobileparts/egghammerfrontwheels2
@onready var egghammerfist: RigidBody2D = $eggmobileparts/egghammerfist
@onready var chain_4: RigidBody2D = $eggmobileparts/chainsback/chain4
@onready var eggmobileparts: Node2D = $eggmobileparts
@onready var playerxmark: Marker2D = $playerxmark
@onready var playerfistmark: Marker2D = $playerfistmark
@onready var hammermark: Marker2D = $hammermark

@onready var egghammer: RigidBody2D = $eggmobileparts/chainsback/egghammer
@onready var egghammerdamagecollision: CollisionShape2D = $eggmobileparts/chainsback/egghammer/egghammerdamage/egghammerdamagecollision

@onready var eggmandeath: AnimatedSprite2D = $eggmobileparts/egghammerbody/eggmandeath

@onready var eggmanhead: AnimatedSprite2D = $eggmobileparts/egghammerbody/eggmanhead
@onready var eggmobile: RigidBody2D = $eggmobileparts/eggmobile

@onready var fistdetect: CollisionShape2D = $fistdetectionarea/fistdetect
@onready var hammerdetect: CollisionShape2D = $hammerdetectionarea/hammerdetect
@onready var iframestimer: Timer = $iframestimer
@onready var highspin: Timer = $highspin
@onready var iframestimer_2: Timer = $iframestimer2
@onready var explosion_4: AnimatedSprite2D = $eggmobileparts/egghammerfist/explosion4
@onready var explosion_5: AnimatedSprite2D = $eggmobileparts/chainsback/egghammer/explosion5
@onready var explosion_6: AnimatedSprite2D = $eggmobileparts/chainsback/egghammer/explosion6
@onready var explosion_1: AnimatedSprite2D = $eggmobileparts/egghammerbody/explosion1
@onready var explosion_2: AnimatedSprite2D = $eggmobileparts/egghammerbody/explosion2
@onready var explosion_3: AnimatedSprite2D = $eggmobileparts/egghammerbody/explosion3
@onready var dyingsound: AudioStreamPlayer = $dyingsound
@onready var hurtsound: AudioStreamPlayer = $hurtsound
@onready var final_explosion: AudioStreamPlayer = $"final explosion"
@onready var eggraised: AudioStreamPlayer = $eggraised


@export var playerchar : Node2D

var takingdamage = false
var eggmanhurtsoundplay = false
var iframes = true
var health = 12
var phase1 = true
var phase2 = false
var phasechange = false
var dying = false
var eggmobilevisible = false
var caughtup = false
var speedbackup = false

var hammerdetects = false
var fistdetects = false
var fistlaunched = false
var hammerraising = false
var hammerraised = false
var hammerslamming = false
var hammergrounded = false
var hammerretracting = false
var hammerstart = false
var hammeractions

var phase1hamspeed = 4
var phase2hamspeed = 6
var radius 
var angle = 45
var newx
var newy
var damagedspeed1 = 8
var damagedspeed2 = 12
var wasdamaged = false
var hitcooldown = false
var bossisfinished = false
var eggmandeathanimation = false

var eggraisesfx = false
var eggraisesnot = true

var finalex = false
var finalnot = true

var sfxhurt = false
var hurtnot = true


func _physics_process(delta: float) -> void:
	
	if Global.bosslevelstart:
		if !caughtup and !speedbackup:
			Global.bosspinch = false
			hammerstart = true
			hammerslamming = false
			global_position.x += 15.5
			egghammerfistdeal.disabled = true
			await get_tree().create_timer(4.0).timeout
			caughtup = true

		elif caughtup and !speedbackup:
			global_position.x += 5.0
			await get_tree().create_timer(1.0).timeout
			speedbackup = true
			caughtup = false

		elif  !caughtup and speedbackup:
			global_position.x += 10.5
			await get_tree().create_timer(2.0).timeout
			speedbackup = true
			caughtup = true
			
		else:
			health = 12
			global_position.x += 8
			egghammerfistdeal.disabled = true
	
	elif health > 0 and !Global.bosslevelstart and !Global.pause:
		global_position.x += 8
		egghammerfistdeal.disabled = false
		egghammerdamagecollision.disabled = false
		
	elif health == 0:
		hammeractions = ""
		global_position.x += 9
		Global.egghammerbossdefeated = true
		Global.pausedisabled = true
		eggmanhead.visible = false
			
	if health < 7 and !phasechange:
		phase2 = true
		phase1 = false
		print("pinch")
		Global.bosspinch = true
		phasechange = true
		
	if takingdamage and iframes and health > health - 1:
		health -= 1
		print("eggman hit")
		print(health)
		takingdamage = false
		
	if health == 0 and !dying and !Global.bossdefeated:

		dying = true
		eggmandeath.visible = true
		eggmandeath.play("default")
		eggmandeathanimation = true
		print("eggmanisdefeated")
		hurtsound.stop()
		Global.bossdefeated = true
		fistdetect.disabled = true
		hammerdetect.disabled = true
		collision_polygon_2d.disabled = true
		egghammerfistdeal.disabled = true
		egghammerdamagecollision.disabled = true
		egghammerbackwheels.freeze = false
		egghammerbackwheels_2.freeze = false
		egghammerbody.freeze = false
		egghammerfist.freeze = false
		egghammerfrontwheels.freeze = false
		egghammerfrontwheels_2.freeze = false
		egghammer.freeze = false
		chain_4.freeze = false
		$eggmobileparts/chainsback/chain3.visible = false
		$eggmobileparts/chainsback/chain5.visible = false
		$eggmobileparts/chainsback/chain6.visible = false
		explosion_1.play("exp1")
		explosion_2.play("exp2")
		explosion_3.play("exp3")
		explosion_4.play("exp4")
		explosion_5.play("exp5")
		explosion_6.play("exp6")
			
	if Global.sonicdied or Global.bosslevelfinished:
		health = 12
		hammeractions = ""
		hammerslamming = false
		takingdamage = false
		eggmanhurtsoundplay = false
		iframes = false
		phase1 = true
		phase2 = false
		phasechange = false
		eggmobilevisible = false
		caughtup = false
		speedbackup = false
		dying = false
		Global.bosspinch = false
		collision_polygon_2d.disabled = true
		
	if Global.bossdefeated and dying:
		await get_tree().create_timer(5.0).timeout
		eggmobilevisible = true
		eggmandeath.visible = false
		eggmanhead.visible = false
		eggmobile.visible = true
	if eggmobilevisible and eggmobile.global_position.y > global_position.y - 100:
		eggmobile.global_position.y -= 5
	if !eggmobilevisible:
		eggmobile.global_position.y = global_position.y
	if dying:
		await get_tree().create_timer(9).timeout
		eggmobileparts.visible = false
		bossisfinished = true
			
	##animations
	if !iframes and !eggmandeathanimation:
		eggmanhead.play("hurt")
	if eggmandeathanimation:
		eggmanhead.visible = false
		eggmandeath.visible = true
		eggmandeath.play("default")
	if iframes and !eggmandeathanimation:
		eggmanhead.play("default")	
		
	##raising hammer
	
	if !Global.bosslevelstart and !dying and !bossisfinished and !Global.pause:
		if phase1 and hammerstart:
			await get_tree().create_timer(1.0).timeout
			hammerraising = true
			
			hammerstart = false
			hammeractions = "hammerbeingraised"
		if phase1 and !hammerraising and !hammerraised:
			hammerslamming = true
			hammeractions = "hammerbeingslammed"
		if phase2:
			hammerslamming = true
			hammeractions = "hammerbeingslammed"
		eggmanAI(delta)		
	
	sfx()
	
func sfx():
	##sound handling
	
	if sfxhurt and hurtnot:
		hurtsound.play()
		hurtnot = false
	

func eggmanAI(delta):
	radius = 100
	if !Global.bosslevelstart and !dying:
			
		match hammeractions:						
					
			"hammerbeingraised":
				if hammerraising and egghammer.global_position.y > 300:
					playerxmark.global_position.x = playerxmark.global_position.x
					print("hammerbeingraised")
					egghammer.global_position.y -=5
					
				elif hammerraising and egghammer.global_position.y <= 300:
					print("hammerrr")
					hammerraised = true
					hammerraising = false
					hammerstart = false
					hammeractions = "hammerattop"
					
			"hammerattop":
				if hammerraised:
					print("hammerraised!")
					
					await get_tree().create_timer(1.0).timeout
					hammerraised = false
					hammerslamming = true
					hammerstart = false
					hammeractions = "hammerbeingslammed"
					
			"hammerbeingslammed":
				if phase1:
					angle += phase1hamspeed * delta
				#if phase1 and hitcooldown:
				#	angle += damagedspeed1 * delta 
				elif phase2:
					angle += phase2hamspeed * delta
				#elif phase2 and hitcooldown:
				#	angle += damagedspeed2 * delta
					
				if hammerslamming:
					
					if !hitcooldown or iframes:
						newx = hammermark.global_position.x + (radius * sin(angle))
						newy = hammermark.global_position.y + (radius * cos(angle))
						egghammer.global_position = Vector2(newx, newy)
					elif hitcooldown and !iframes:
						newx = hammermark.global_position.x + (radius * sin(angle * 2))
						newy = hammermark.global_position.y + (radius * cos(angle * 2))
						egghammer.global_position = Vector2(newx, newy)
					

func _on_eggmantakedamagebox_area_entered(area: Area2D):
	if area.is_in_group("playerdeal") and iframes and health > 0 and !takingdamage:
		iframes = false
		takingdamage = true

		hitcooldown = true
		sfxhurt = true
		highspin.start()
		if phase1:
			iframestimer.start()
		if phase2:
			iframestimer_2.start()
	
		










func _on_iframestimer_timeout() -> void:
	iframes = true
	hurtnot = true
	sfxhurt = false	
	collision_polygon_2d.disabled = false
	eggmantakedamagebox.monitoring = true


func _on_highspin_timeout() -> void:
	hitcooldown = false
