extends CharacterBody2D



### ### Maddie's Ultra-Simple Sonic Physics!! ### ###
## Don't want comments? Alright, I'll remove all the useless ones.

#figured i'd do this as well cuz the script is wayyy different now, so here you go!

@onready var takedmgnoball: CollisionShape2D = $takedamageboxnoball/takedmgnoball
@onready var takedmgball: CollisionShape2D = $takedamageball/takedmgball
@onready var dealdamageball: CollisionShape2D = $dealdamage/dealdamageball
@onready var collisionchecker: CollisionShape2D = $collisioncheckernoball/collisionchecker

@onready var shotleft: Marker2D = $Collision/shotleft

@export var ringflingleft = load("res://sonic engine things/objects/rings/ringleft.tscn")

var newringflungleft = ringflingleft.instantiate()

var motion := Vector2(0, 0)
var rot := 0.0
var grounded := false
var slopeangle := 0.0
var slopefactor := 0.0
var falloffwall = false
var control_lock = false
var stuck = false
var jumping = false
var canjump = false
var jumpbuffered = false
const JUMP_VELOCITY = 400.0
var GRAVITY = 650
var acc := 2
var dec := 30.0
var topspeed := 550.0
var maxspeed := 700.0
var crouching = false
var ballstate = false
var spindashing = false
var spindashspeed = 0
var spindashmaxspeed = 400
var dropdashing = false
var dropdashspeed := 350
var dropdashcool = false
var airdashing = false
var airdashspeed := 300
var airdashreset = false
var airdashanim = false
var gettinghurt = false
var hurt = false
var iframes = false
var spring = false
var ringcount = 0
var death = false
var dead = false
var ringsflung = false
var ringbeingflung = false
var ringsspawned = 0
var maxringsspawn = 15
var currentrings
var redvelocity := 800
var yelvelocity := 400
var springtype
var bouncing = false

@export var underwater = false
@export var facingleft = false
@export var facingright = true

func _process(delta: float):
	Levelscriptex.ringssonichas = ringcount
	if ringcount > 15 and !gettinghurt:
		currentrings = 15
	elif ringcount < 15 and !gettinghurt:
		currentrings = ringcount
		
func _physics_process(delta):
# Set the Slope variables
	if is_on_floor():
		slopeangle = get_floor_normal().angle() + (PI/2)
		slopefactor = get_floor_normal().x
	else:
		slopefactor = 0
		
# Rotation & Momentum Conversion
	$Collision.rotation = rot
	$Sprite.rotation = lerp_angle($Sprite.rotation, rot, 0.25)
	$takedamageboxnoball.rotation = rot
	$takedamageball.rotation = rot
	$dealdamage.rotation = rot
	$collisioncheckernoball.rotation = rot

	if is_on_floor() and !spring and !death:
		airdashreset = false 
		airdashanim = false
		if !hurt:
			gettinghurt = false
		if not grounded and !death and !gettinghurt:
			if abs(slopeangle) >= 0.25 and abs(motion.y) > abs(motion.x):
				motion.x += motion.y * slopefactor
			grounded = true	
		up_direction = get_floor_normal()
		rot = slopeangle	
	elif !spring:	
		if not $Collision/Raycast.is_colliding() and grounded:
			grounded = false
			motion = get_real_velocity()
			rot = 0
			up_direction = Vector2(0, -1)
	elif spring and abs(slopefactor) == 1:
		rot = 0
		up_direction = Vector2(0, -1)
	elif abs(rot) > 1: 
		position += Vector2(0, -(14)).rotated(rot)
		rot = 0
		up_direction = Vector2(0, -1)		
	elif gettinghurt and abs(slopefactor) == 1:
		rot = 0
		up_direction = Vector2(0, -1)
	elif abs(rot) > 1 and gettinghurt: 
		position += Vector2(0, -(14)).rotated(rot)
		rot = 0
		up_direction = Vector2(0, -1)
	elif death:
		position += Vector2(0, -(14)).rotated(rot)
		rot = 0
		up_direction = Vector2(0, -1)
		
# Gravity
	if not is_on_floor() and rot == 0: 
		motion.y += GRAVITY * delta
	elif death: 
		motion.y += GRAVITY * delta
	elif gettinghurt:
		motion.y += GRAVITY * delta
	elif !spring and !death and !gettinghurt:
		if abs(slopefactor) == 1 and !spring: 
			motion.y = 0
		elif !spring and !death and !gettinghurt:
			motion.y = 50
			
	
#spring match
	match springtype:
		"redspringup":
			if spring:
				if grounded:
					motion.y = -redvelocity
					motion.x = 0
				elif !grounded and jumping:
					motion.y = -redvelocity
					motion.x = 0
					jumping = false
				elif !grounded:
					motion.y = -redvelocity
					motion.x = 0
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringup":
			if spring:
				if grounded:
					motion.y = -yelvelocity
					motion.x = 0
				elif !grounded and jumping:
					motion.y = -yelvelocity
					motion.x = 0
					jumping = false
				elif !grounded:
					motion.y = -yelvelocity
					motion.x = 0
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"redspringd":
			if spring:
				if grounded:
					motion.y == redvelocity
					motion.x = 0
				elif !grounded and jumping:
					motion.y = redvelocity
					motion.x = 0
					jumping = false
				elif !grounded:
					motion.y = redvelocity
					motion.x = 0
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringd":
			if spring:
				if grounded:
					motion.y = yelvelocity
					motion.x = 0
				elif !grounded and jumping:
					motion.y = yelvelocity
					motion.x = 0
					jumping = false
				elif !grounded:
					motion.y = yelvelocity
					motion.x = 0
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"redspringr":
			if spring:
				if grounded:
					motion.x = redvelocity
					motion.y = 0
				elif !grounded and jumping:
					motion.x = redvelocity
					motion.y = 0
					jumping = false
				elif !grounded:
					motion.x = redvelocity
					motion.y = 0
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringr":
			if spring:
				if grounded:
					motion.x = yelvelocity
					motion.y = 0
				elif !grounded and jumping:
					motion.x = yelvelocity
					motion.y = 0
					jumping = false
				elif !grounded:
					motion.x = yelvelocity
					motion.y = 0
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"redspringl":
			if spring:
				if grounded:
					motion.x = -redvelocity
					motion.y = 0
				elif !grounded and jumping:
					motion.x = -redvelocity
					motion.y = 0
					jumping = false
				elif !grounded:
					motion.x = -redvelocity
					motion.y = 0
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringl":
			if spring:
				if grounded:
					motion.x = -yelvelocity
					motion.y = 0
				elif !grounded and jumping:
					motion.x = -yelvelocity
					motion.y = 0
					jumping = false
				elif !grounded:
					motion.x = -yelvelocity
					motion.y = 0
				spring = false
				ballstate = false
				canjump = false	
				gettinghurt = false
		"redspringupr":
			if spring:
				if grounded:
					motion.y = -redvelocity
					motion.x = redvelocity
				elif !grounded and jumping:
					motion.y = -redvelocity
					motion.x = redvelocity
					jumping = false
				elif !grounded:
					motion.y = -redvelocity
					motion.x = redvelocity
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringupr":
			if spring:
				if grounded:
					motion.y = -yelvelocity
					motion.x = yelvelocity
				elif !grounded and jumping:
					motion.y = -yelvelocity
					motion.x = yelvelocity
					jumping = false
				elif !grounded:
					motion.y = -yelvelocity
					motion.x = yelvelocity
				spring = false
				ballstate = false
				canjump = false	
				gettinghurt = false
		"redspringupl":
			if spring:
				if grounded:
					motion.y = -redvelocity
					motion.x = -redvelocity
				elif !grounded and jumping:
					motion.y = -redvelocity
					motion.x = -redvelocity
					jumping = false
				elif !grounded:
					motion.y = -redvelocity
					motion.x = -redvelocity
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringupl":
			if spring:
				if grounded:
					motion.y = -yelvelocity
					motion.x = -yelvelocity
				elif !grounded and jumping:
					motion.y = -yelvelocity
					motion.x = -yelvelocity
					jumping = false
				elif !grounded:
					motion.y = -yelvelocity
					motion.x = -yelvelocity
				spring = false
				ballstate = false
				canjump = false	
				gettinghurt = false
		"redspringdr":
			if spring:
				if grounded:
					motion.y = redvelocity
					motion.x = redvelocity
				elif !grounded and jumping:
					motion.y = redvelocity
					motion.x = redvelocity
					jumping = false
				elif !grounded:
					motion.y = redvelocity
					motion.x = redvelocity
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringdr":
			if spring:
				if grounded:
					motion.y = yelvelocity
					motion.x = yelvelocity
				elif !grounded and jumping:
					motion.y = yelvelocity
					motion.x = yelvelocity
					jumping = false
				elif !grounded:
					motion.y = yelvelocity
					motion.x = yelvelocity
				spring = false
				ballstate = false
				canjump = false	
				gettinghurt = false
		"redspringdl":
			if spring:
				if grounded:
					motion.y = redvelocity
					motion.x = -redvelocity
				elif !grounded and jumping:
					motion.y = redvelocity
					motion.x = -redvelocity
					jumping = false
				elif !grounded:
					motion.y = redvelocity
					motion.x = -redvelocity
				spring = false
				ballstate = false
				canjump = false
				gettinghurt = false
		"yellowspringdl":
			if spring:
				if grounded:
					motion.y = yelvelocity
					motion.x = -yelvelocity
				elif !grounded and jumping:
					motion.y = yelvelocity
					motion.x = -yelvelocity
					jumping = false
				elif !grounded:
					motion.y = yelvelocity
					motion.x = -yelvelocity
				spring = false
				ballstate = false
				canjump = false	
				gettinghurt = false
		"bumper":
			if spring:
				motion.y * -0.5
				motion.x * -0.5
				spring = false
				canjump = false		
		"gottenhurt": 
			if gettinghurt and ringcount > 0:
				spring = false
				if ringcount > 0: 
					$"sonic sfx/ringloss".play()
					position += Vector2(0, -(14)).rotated(rot)
					$timers/iframestime.start()
					iframes = true
					ringsflung = true
					ringcount = 0
					if facingleft and hurt:
						motion.x += 300 
						motion.y = -150
						hurt = false
					if facingright and hurt:
						motion.x += -300 
						motion.y = -150
						hurt = false						
				if ringcount == 0: 
					if hurt: 
						death = true
						dead = true
						hurt = false
						gettinghurt = false	
		"enemy bounce":
			if bouncing and spring:
				canjump = false
				if ! grounded and jumping and !Input.is_action_pressed("jump"):
					motion.y += abs(motion.y) + abs(motion.x) * -40
				elif !grounded and !jumping:
					motion.y += -400
				bouncing = false
				spring = false

# Jump
	if Input.is_action_just_pressed("jump") and !crouching and !spindashing and !death and !gettinghurt:	
		crouching = false
		spindashing = false
		jumpbuffered = true
		$timers/JumpBufferTimer.start()
	if not grounded and canjump: 
		if $timers/CoyoteTimer.is_stopped():
			$timers/CoyoteTimer.start()
	else:
		$timers/CoyoteTimer.stop()
		
	if jumpbuffered and canjump  and !death and !spring and !bouncing: 
		$"sonic sfx/jumpsfx".play()
		if ballstate and abs(motion.x) > 650:
			motion.y = -JUMP_VELOCITY * 1.2
			ballstate = false
		else:
			motion.y = -JUMP_VELOCITY
			ballstate = false
		jumping = true
		canjump = false	
		if abs(rot) > 1: 
			position += Vector2(0, -(14)).rotated(rot)
		$timers/JumpBufferTimer.stop()
		jumpbuffered = false
	if motion.y >= 0 and grounded: 
		jumping = false
		canjump = true
	if jumping and motion.y < -JUMP_VELOCITY / 1.625 and !spring and !gettinghurt and !death and !bouncing: 
		if not Input.is_action_pressed("jump") and !death and !spring and !bouncing: 
			motion.y = -JUMP_VELOCITY / 1.625

# (Debug) Speed Boost
	#if Input.is_action_just_pressed("action"):
	#	motion.x += topspeed * sign($Sprite.scale.x)
	
# Movement
	var direction = Input.get_axis("left", "right") 
	if $Sprite.scale.x == -1 and !spindashing and !dropdashing:
		facingleft = true
		facingright = false
	if $Sprite.scale.x == 1 and !spindashing and !dropdashing:
		facingleft = false
		facingright = true
		
	if direction and not control_lock and not ballstate and not crouching and !death and !gettinghurt: # If holding left or right, and not slipping down a slope...
		if is_on_floor() and !spring: 
			if direction == sign(motion.x):
				if abs(motion.x) <= maxspeed:
					motion.x += acc * direction	
			else: 
				if abs(slopefactor) < 0.4: 
					motion.x += dec * direction
					if ($"sonic sfx/stoppingsfx").playing == false and abs(motion.x) > 250:
						$"sonic sfx/stoppingsfx".play()
				elif !death: 
					motion.x += acc * direction					
		elif !gettinghurt or !death: 
			if direction == sign(motion.x): 
				if abs(motion.x) <= topspeed: 
					motion.x += (acc * 2) * direction	
			elif !death: 
				motion.x += (acc * 2) * direction
	elif !spring and !death and !gettinghurt: 
		if is_on_floor() and abs(slopefactor) < 0.25: 
			motion.x = move_toward(motion.x, 0, acc)
	elif death:
		motion.x = 0
		
# Set Velocity to the Motion variable, but rotated.
	velocity = Vector2(motion.x, motion.y).rotated(rot)

#dropdash
	if Input.is_action_pressed("action") and !grounded and ! dropdashcool and !airdashing and !death and !gettinghurt:
		dropdashing = true 
		canjump = false
		if $"sonic sfx/spindashsfx".playing == false:
			$"sonic sfx/spindashsfx".play()
	if Input.is_action_just_released("action") and !grounded:
		dropdashing = false
		$"sonic sfx/spindashsfx".stop()
	if grounded and dropdashing  and !death and !gettinghurt:
		ballstate = true
		dropdashcool = true
		$"sonic sfx/dashrelease".play()
		if facingleft:
			motion.x = dropdashspeed * -1 * acc
		if facingright:
			motion.x = dropdashspeed * 1 * acc
		dropdashing = false
		$timers/dropdashcooldown.start()

# rolling
	if Input.is_action_pressed("down") and abs(motion.x) > 1 and grounded and !death and !gettinghurt:
		ballstate = true
		if $"sonic sfx/spindashsfx".playing == false:
			$"sonic sfx/spindashsfx".play()
	
# crouching
	if Input.is_action_pressed("down") and abs(motion.x) < 1 and grounded and !death and !spring and !gettinghurt:
		crouching = true 
	if Input.is_action_just_released("down") and abs(motion.x) < 1 and grounded and crouching and !death and !gettinghurt:
		crouching = false 
		ballstate = false
	elif !Input.is_action_pressed("down") and abs(motion.x) < 1 and grounded and crouching and !death and !gettinghurt:
		crouching = false
		
# Spindashing
	if crouching and Input.is_action_just_pressed("action") and grounded and !death and !gettinghurt:
		spindashing = true 
		$"sonic sfx/spindashsfx".play()
		if spindashspeed < spindashmaxspeed:
			spindashspeed += 120
		elif spindashspeed >= spindashmaxspeed:
			spindashspeed = spindashmaxspeed 
	elif Input.is_action_just_released("down") and spindashing and grounded and !death and !gettinghurt:
		ballstate = true 
		$"sonic sfx/dashrelease".play()
		if facingleft:
			motion.x += spindashspeed * -1 * acc
		if facingright:
			motion.x += spindashspeed * 1 * acc
		crouching = false
		spindashing = false
		spindashspeed = 0
		
#airdash
	if Input.is_action_just_pressed("action2") and !grounded and !dropdashing and !airdashreset and !death and !gettinghurt:
		airdashing = true 
		airdashreset = true
		airdashanim = true
		ballstate = false		
	if airdashing and !grounded and !death and !gettinghurt:
		$"sonic sfx/airdash".play()
		$timers/airdashcooldown.start()
		if facingleft:
			motion.x = airdashspeed * -1 * acc
			motion.y = -250
		if facingright:
			motion.x = airdashspeed * 1 * acc
			motion.y = -250
		airdashing = false
				
#ballstate control	
	if ballstate and !is_on_floor() and !Input.is_action_pressed("down") and !bouncing:
		ballstate = false 		
	if ballstate and is_on_floor() and not stuck and not $Collision/WallCast.is_colliding() and !death and !gettinghurt:
		motion.x += (acc * 0.8) * slopefactor	
	elif ballstate and abs(motion.x) < 50:
		$timers/"ballstate timer".start()	
	if ballstate and abs(motion.x) > 1250: 
		ballstate = false 

# Slopes
	if is_on_floor() and not stuck and not $Collision/WallCast.is_colliding() and !gettinghurt and !spring and !death:
		motion.x += (acc * 2) * slopefactor
	if grounded and abs(slopefactor) >= 0.5 and abs(motion.x) < 10 and !spring and !death and !gettinghurt: 
		control_lock = true
		$timers/ControlLockTimer.start()
	if grounded and abs(slopeangle) > 1.5 or spring and abs(slopeangle) > 1.5 and !death and !gettinghurt: 
		if abs(motion.x) < 285:
			falloffwall = true
			position += Vector2(0, -(14)).rotated(rot)
			canjump = false
			control_lock = true
			$timers/ControlLockTimer.start()
	elif spring or gettinghurt or death:
		falloffwall = true
	else:
		falloffwall = false
	
# Stoppers
	if is_on_ceiling() and not grounded:
		if motion.y < 0:
			motion.y = 100
			ballstate = false
	if is_on_wall() and $Collision/WallCast.is_colliding(): 
		motion.x = 0
		ballstate = false			
	ringfling()
	collision()
	animate()
	move_and_slide()

func ringfling():
	maxringsspawn = currentrings 
	if ringsflung:	
		if ringsspawned < maxringsspawn  and gettinghurt: 
			print("ringflung")
			get_parent().add_child(newringflungleft.duplicate())
			newringflungleft.global_position = shotleft.global_position 
			ringsspawned += 1 
		elif ringsspawned == maxringsspawn: 
			ringsspawned = 0 
			currentrings = 0 
			ringsflung = false

func dying():
	if death and Global.lifecount > 0: 
		if dead: #lose a life
			gettinghurt = false
			hurt = false
			falloffwall = true
			Global.lifecount -= 1
			motion.y = -300
			motion.x = 0
			$"timers/lost life".start()
			Global.sonicdied = true
			dead = false
		
	elif death and Global.lifecount == 0:
		if dead: 
			motion.y = -300
			motion.x = 0
			Global.gameover = true
			Global.sonicdied = true
			dead = false

func collision():
	if jumping and !death or ballstate and !death or spindashing and !death or crouching and !death:
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = false
		dealdamageball.disabled = false
	if jumping and iframes and !death or ballstate and iframes and !death or spindashing and iframes and !death or crouching and iframes and !death:
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = true
		dealdamageball.disabled = false		
	elif iframes and !death:
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = true
		dealdamageball.disabled = true
	elif !death and !jumping and !ballstate and !spindashing and !crouching:
		takedmgnoball.disabled = false
		collisionchecker.disabled = false
		takedmgball.disabled = true
		dealdamageball.disabled = true
	elif death:
		takedmgnoball.disabled = true
		collisionchecker.disabled = true
		takedmgball.disabled = true
		dealdamageball.disabled = true
		$Collision.disabled = true	

# Animation
var idle := true
var idleset := false

func animate():
	if abs(motion.x) > 1:
		$Sprite.scale.x = sign(motion.x)
		$Collision.scale.x = sign(motion.x)
	if grounded:
		if abs(motion.x) < 1: 
			$Sprite.speed_scale = 1			
		elif abs(motion.x) < topspeed - 100 and !ballstate and !death:
			$Sprite.play("walk")
			$Sprite.speed_scale = 0.2 + (abs(motion.x) / 550)			
		elif abs(motion.x) < maxspeed - 10 and !ballstate and !death:
			$Sprite.play("run")
			$Sprite.speed_scale = 1 + (abs(motion.x) /  750)			
		elif !ballstate and !death:
			$Sprite.play("top speed")
			$Sprite.speed_scale = 1.5 + (abs(motion.x) / (maxspeed * 2))	
		elif ballstate and !spindashing and !death:
			$Sprite.play("jump")
			$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif jumping and !airdashanim and !death and !gettinghurt:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif ballstate and !airdashanim and !death and !gettinghurt:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))	
	elif !grounded and motion.y > 1 and !ballstate and abs(motion.x) < 650 and !dropdashing and !airdashanim and !death and !gettinghurt:
		$Sprite.play("fall")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif !grounded and motion.y < 1 and !ballstate and abs(motion.x) < 650 and !dropdashing and !airdashanim and !death and !gettinghurt:
		$Sprite.play("flight")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif !grounded and !ballstate and abs(motion.x) > 650 and !dropdashing and !airdashanim and !death and !gettinghurt:
		$Sprite.play("sideflight")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif !grounded and ballstate and !airdashanim and !death and !gettinghurt:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif !grounded and dropdashing and !death and !gettinghurt:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif airdashanim and !grounded and !dropdashing and !death and !gettinghurt:
		$Sprite.play("airdash")
	elif gettinghurt and !death:
		$Sprite.play("hurt")
	elif !gettinghurt and death:
		$Sprite.play("hurt")
			
	# Idle animation
	if grounded and spindashing and abs(motion.x) < 1 and !death:
			$Sprite.play("spindashrev")
			$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))	
	if grounded and abs(motion.x) < 1 and crouching and !spindashing and !ballstate and !death:
		$Sprite.play("crouching")	
	if grounded and abs(motion.x) < 1 and !crouching and !spindashing:
		idle = true
	else:
		idle = false
	if idle:
		if idleset:
			$Sprite.play("idle")
			ballstate = false
			idleset = false		
		if $timers/IdleTimer.is_stopped():
			$timers/IdleTimer.start()
	else:
		idleset = true
		$timers/IdleTimer.stop()

func _on_idle_timer_timeout():
	if abs(motion.x) < 1 and !death:
		$Sprite.play("idleanim")

# Timer signals and area detection
func _on_control_lock_timer_timeout():
	control_lock = false

func _on_jump_buffer_timer_timeout():
	jumpbuffered = false

func _on_coyote_timer_timeout():
	canjump = false

func _on_ballstate_timer_timeout() -> void:
	ballstate = false 
	
func _on_dropdashcooldown_timeout() -> void:
	dropdashcool = false 

func _on_takedamageboxnoball_area_entered(area: Area2D):
	if area.is_in_group("enemy"):	
		if ringcount > 0:
			springtype = "gottenhurt"
			gettinghurt = true
			hurt = true
			jumping = false
			ballstate = false
		elif ringcount == 0:
			death = true
			dead = true
			dying()
			jumping = false
			ballstate = false

func _on_iframestime_timeout() -> void:
	iframes = false

func _on_takedamageball_area_entered(area: Area2D):
	if area.is_in_group("enemy") and !bouncing:
		if ringcount > 0:
			springtype = "gottenhurt"
			gettinghurt = true
			hurt = true
			jumping = false
			ballstate = false
		elif ringcount == 0:
			death = true
			dead = true
			dying()
			jumping = false
			ballstate = false
	
func _on_dealdamage_area_entered(area: Area2D):
	if area.is_in_group("enemy") and !gettinghurt:
		springtype = "enemy bounce"
		bouncing = true
		spring = true

func _on_lost_life_timeout() -> void:
	Global.sonicdied = false
	get_tree().reload_current_scene()

func _on_collisioncheckernoball_area_entered(area: Area2D):
	if area.is_in_group("kill"): 
		death = true
		dead = true
		dying()
		jumping = false
		ballstate = false
	if area.is_in_group("redspring"):
		springtype = "redspringup"
		spring = true
	if area.is_in_group("yellowspring"):
		springtype = "yellowspringup"
		spring = true
	if area.is_in_group("redspringdown"):
		springtype = "redspringd"
		spring = true
	if area.is_in_group("yellowspringdown"):
		springtype = "yellowspringd"
		spring = true
	if area.is_in_group("redspringleft"):
		springtype = "redspringl"
		spring = true
	if area.is_in_group("yellowspringleft"):
		springtype = "yellowspringl"
		spring = true
	if area.is_in_group("redspringright"):
		springtype = "redspringr"
		spring = true
	if area.is_in_group("yellowspringright"):
		springtype = "yellowspringr"
		spring = true
	if area.is_in_group("redspringupright"):
		springtype = "redspringupr"
		spring = true
	if area.is_in_group("yellowspringupright"):
		springtype = "yellowspringupr"
		spring = true
	if area.is_in_group("redspringupleft"):
		springtype = "redspringupl"
		spring = true
	if area.is_in_group("yellowspringupleft"):
		springtype = "yellowspringupl"
		spring = true
	if area.is_in_group("redspringdownright"):
		springtype = "redspringdr"
		spring = true
	if area.is_in_group("yellowspringdownright"):
		springtype = "yellowspringdr"
		spring = true
	if area.is_in_group("redspringdownleft"):
		springtype = "redspringdl"
		spring = true
	if area.is_in_group("yellowspringdownleft"):
		springtype = "yellowspringdl"
		spring = true
	if area.is_in_group("ring"): 
		if !gettinghurt:
			ringcount += 1
			print(ringcount)
		elif gettinghurt:
			await get_tree().create_timer(1.0).timeout
			ringcount += 1
			print(ringcount)

func _on_airdashcooldown_timeout() -> void:
	airdashanim = false 

## Squeaky clean.
