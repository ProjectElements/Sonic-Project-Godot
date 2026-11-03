extends CharacterBody2D

class_name player

@onready var takedmgnoball: CollisionShape2D = $takedamageboxnoball/takedmgnoball
@onready var takedmgball: CollisionShape2D = $takedamageball/takedmgball
@onready var dealdamageball: CollisionShape2D = $dealdamage/dealdamageball
@onready var collisionchecker: CollisionShape2D = $collisioncheckernoball/collisionchecker
@onready var instashape: CollisionShape2D = $instaball/instashape

#collision variables

@onready var shotleft: Marker2D = $Collision/shotleft
#the spot where your rings fly out


#loads the rings that fly out of sonic
@export var ringflingleft = load("res://sonic engine things/objects/rings/ringleft.tscn")

var newringflungleft = ringflingleft.instantiate()

### ### Maddie's Ultra-Simple Sonic Physics!! ### ###
## The absolute bare minimum needed to make a Sonic fangame.

## Right now, it's just the 360 degree movement and slope physics, nothing else.

## I've written tons of helpful comments in the hopes that you'll understand how this code works.
## Then, if you do, I enGlobal.drownmusic = truecourage you to try and add stuff like a spindash or a boost, if you want.


## I've also set bookmarks for each segment of the script.

## To access the bookmarks, look above that text field at the top left that says "Filter Scripts"-
## -and click "Go To". Then, click "Bookmarks". Now you'll hopefully be able to-
## -easily navigate this script.


## If you end up using this for a game, credit is absolutely not required, but would be appreciated.


## If the comments get annoying, find the script labelled "player (no comments)"-
## -and swap this script out with that one.




## Variables go at the top. Let's start with the most important ones.

var motion := Vector2(0, 0)
# Motion, the magical variable. Consider it a pseudo-Velocity.
## Motion and Velocity are used in conjunction with each other to simulate the 360 degree movement-
## -found in Classic Sonic games, only with much more theoretical effectiveness.
## Check underneath the "Movement" segment of the script for a full explanation.

var rot := 0.0
# Rotation.
## This helps your Sprite and Collision rotate.

var grounded := false
# The state that tracks if you've left the floor.
## Walking on a wall or a ceiling also counts as being grounded.

var slopeangle := 0.0
# The exact angle (in Radians) of the floor you're standing on.
## This number will be positive if the slope rises to the left, and negative if it rises to the right.
# Why Radians?
# Because Degrees calculations are finicky in this engine. Radians are far more accurate.

var slopefactor := 0.0
# The steepness of the slope you're standing on.
## Straight floors and cielings will emit "0". Perfectly vertical walls will emit "1".
## This number will be positive if the slope rises to the left, and negative if it rises to the right.




## Fixes for problems involving walls and steep slopes.

var falloffwall = false
# This makes sure you can't permanently stick to the wall.
## See the "Slope" section of the script for more info.

var control_lock = false
# This briefly removes your ability to move if you're trying to walk up a slope that's far too steep.
## See the "Slope" section of the script for more info.

var stuck = false
# This one activates in a very specific situation involving a steep downward slope and a wall.
## See the very bottom of this script for more info.




## Jump variables. These help us make a Jump mechanic that feels really good.

var jumping = false
# Activates if you've successfully left the ground by Jumping.
## This one is necessary for our Variable Jump Height.

var canjump = false
# Whether or not you're able to jump. When deactivated, your jump button will become useless.
## This one is necessary for our Coyote Timer.

var jumpbuffered = false
# Briefly activates every time you press the Jump button.
## This one variable is necessary for our Jump Buffer.




## The Player's stats.

const JUMP_VELOCITY = 400.0
# Jump height. Default: 350.0

var GRAVITY = 650
# Gravity force. Default: 600

var acc := 2
# Acceleration. Default: 2
# This is what moves you forward.

var dec := 30.0
# Deccelleration. Default: 30.0
## This is only used when you try to turn around.

var topspeed := 550.0
# Top Speed. Default: 300.0
## You won't be able to Accelerate past this point without some Momentum.

var maxspeed := 700.0
#absolute max speed you can achieve without momentum

var crouching = false
#are you crouching or not?

var ballstate = false
#are you curled in a ball or not?

var spindashing = false
#are you revving up a spindash

var spindashspeed = 0
#current spindash speed

var spindashmaxspeed = 400
#maximum speed you can rev up a spindash to

var dropdashing = false
#are you dropdashing

var dropdashspeed := 350
#speed at which your dropdash goes

var dropdashcool = false
#is your dropdash still in cooldown

var airdashing = false
#are you airdashing

var airdashspeed := 300
#speed at which your airdash goes

var airdashreset = false
#doesnt allow you to airdash if you've already done so

var airdashanim = false
#controls the animations for the air dash

var gettinghurt = false
#did you get hit

var hurt = false
#enables hurt actions

var iframes = false
#are your iframes active

var spring = false
#are you hitting a spring

var ringcount = 0
#your current ring count

var death = false
#are you dying

var dead = false
#enables dead actions

var ringsflung = false

var ringbeingflung = false

var ringsspawned = 0

var maxringsspawn = 15

var currentrings

var redvelocity := 800
#speed that red springs send you

var yelvelocity := 400
#speed that yellow springs send you

var springtype
#which spring is currently in your area

var bouncing = false
#checks if you are bouncing off of an enemy

var intube = false
#checks if you are in a tube

var tubesfxplaying = false
#if ypu enter a tube, play the sfx

var passedgoal = false

var levelstart = false

var bossstart = false

var bossdefeat = false

var againstwall = false

@export var underwater = false
#are you underwater

@export var gravityreversed = false

@export var facingleft = false

@export var facingright = true

@onready var drowningtimerinit: Timer = $timers/drowningtimerinit
@onready var drowntimecountdown: Timer = $timers/drowntimecountdown
@onready var _3_sec: Timer = $"timers/3sec"

@onready var instatimer: Timer = $timers/instatimer

@export var chkpt1 : Node2D
@export var chkpt2 : Node2D
@export var chkpt3 : Node2D
@export var chkpt4 : Node2D
@export var chkpt5 : Node2D

var CD5 = false
var CD4 = false
var CD3 = false
var CD2 = false
var CD1 = false
var CD0 = false

var drowned = false
var drowntimerstarted = false

var instashield = false
var caninsta = true
var instcool = false

var ispushing = false

var airdashup = -250
var againstwallmax = 20

@export var icephysics = false

@export var onIce = false

@export var shielded = false

@export var hasshield = false

@onready var shields: AnimatedSprite2D = $shields

var opaque = true

var flashtime = false

@onready var flashingtim: Timer = $timers/flashing

var storedvelx
var storedvely
var velocityapplied = true

@export var drowningreset = false

var bubbleanim = false

var bubblesound = false

var bubblesoundplaying = false


@export var cutscenedisable = false

@export var gimmickdisable = false

## Note: If you'd like to change the player's stats mid-game, make them variables instead.
## You can do this by changing the word "const" to "var".


func _process(delta: float):
	
	if Global.sonicpassedsign:
		passedgoal = true
	else:
		passedgoal = false
		
	if Global.bossdefeated or Global.bossclearscreen or Global.bosslevelfinished or Global.calculatingfinalscore or Global.bosslevelfinished or Global.egghammerbossdefeated:
		bossdefeat = true
		
	else:
		bossdefeat = false
	Global.sonicsrings = ringcount
	#updates sonics ring count in the level
	if ringcount > 15 and !gettinghurt:
		currentrings = 15
	elif ringcount < 15 and !gettinghurt:
		currentrings = ringcount
		
	if Global.levelstarting:
		levelstart = true
		shielded = false
	else:
		levelstart = false
		
	if Global.bosslevelstart:
		bossstart = true
		shielded = false
	else:
		await get_tree().create_timer(1.0).timeout
		bossstart = false
		
	if Global.isunderwater:
		underwater = true
		if !drowntimerstarted and !drowningreset:
			drowntimerstarted = true
			drowningtimerinit.start()
	elif !Global.isunderwater and !dead :
		underwater = false
		drowntimerstarted = false	
		drowningtimerinit.stop()
		drowntimecountdown.stop()
		_3_sec.stop()
		Global.drownmusic = false
		
	if Levelscriptex.currentleveltimemin == 15 and !death and !dead:
		death = true
		dead = true
		shielded = false
		Global.timeover = true
		GloBcheck.checkpoint1 = false
		GloBcheck.checkpoint2 = false
		GloBcheck.checkpoint3 = false
		GloBcheck.checkpoint4 = false
		GloBcheck.checkpoint5 = false
		dying()
		jumping = false
		ballstate = false
	if levelstart and GloBcheck.checkpoint1:
		global_position = chkpt1.global_position
	if levelstart and GloBcheck.checkpoint2:
		global_position = chkpt2.global_position
	if levelstart and GloBcheck.checkpoint3:
		global_position = chkpt3.global_position
	if levelstart and GloBcheck.checkpoint4:
		global_position = chkpt4.global_position
	if levelstart and GloBcheck.checkpoint5:
		global_position = chkpt5.global_position
	
	
	
		
## Alright, let's get started.

func _physics_process(delta):

		
# Set the Slope variables
	if is_on_floor():
		slopeangle = get_floor_normal().angle() + (PI/2)
		# This takes the angle of the floor and rotates it 90 degrees.
		
		slopefactor = get_floor_normal().x
		# Your acceleration will be affected based on how steep the slope is.
		## You'll slow down the most on a perfectly vertical wall,
		## and and !Global.sonicdied the least on the flat floor or the ceiling.
	else:
		slopefactor = 0
		# This makes sure your acceleration isn't affected by slopes while you're not on the ground.




# Rotation & Momentum Conversion
	$Collision.rotation = rot
	# Snap your Collision's rotation with the floor.
	## This ensures consistency when running along slopes.
	
	$Sprite.rotation = lerp_angle($Sprite.rotation, rot, 0.25)
	$shields.rotation = lerp_angle($shields.rotation, rot, 0.25)
	# Smoothly Interpolate your Sprite's rotation with the floor, somewhat similarly to Sonic Mania.
	## Looks nice!
	$takedamageboxnoball.rotation = rot
	$takedamageball.rotation = rot
	$dealdamage.rotation = rot
	$collisioncheckernoball.rotation = rot
	# rotates your hitboxes


	if is_on_floor() and !spring and !death:
		airdashreset = false #resets your air dash and air dash animation when you hit the ground
		airdashanim = false
		caninsta = true
		instashield = false
		$fx.visible = false
		if !hurt:
			gettinghurt = false #disables the variable in charge of hurt actions
			
		# Momentum Conversion
		if not grounded and !death and !gettinghurt:
			if abs(slopeangle) >= 0.25 and abs(motion.y) > abs(motion.x): # If you land on a slope-
				# -and are falling faster than you're moving...
				motion.x += motion.y * slopefactor
				# Add Vertical Speed to Horizontal Speed based on the slope's steepness.
			grounded = true
		
		# Rotation
		up_direction = get_floor_normal()
		rot = slopeangle
		# The Up Direction is what helps you differentiate a wall from a floor.
		
		## This engine's platformer logic is simple:
		## You bump into walls, walk on floors, and bonk on ceilings.
		
		## By normal means, you can't walk on walls...
		## ...but by changing the Up Direction, we can change what the game defines as a floor,
		## thereby letting you walk on walls and ceilings.
		
		## Of course, we have to rotate the player along the floor as well,
		## otherwise that would cause some visual bugs.
		
	elif !spring: # If not on the floor anymore...
		# Reset Rotation and apply Momentum
		if not $Collision/Raycast.is_colliding() and grounded:
			grounded = false
			
			motion = get_real_velocity()
			# Set your motion to your actual velocity.
			## This is what converts your momentum when you fly off a slope.
			
			rot = 0
			up_direction = Vector2(0, -1)
			# Set your Rotation and Up Direction to their defaults.
	elif spring and abs(slopefactor) == 1: #if you are on a wall and hit a spring
		rot = 0
		up_direction = Vector2(0, -1)
		# Set your Rotation and Up Direction to their defaults.
	elif abs(rot) > 1: #if you are on the ceiling and hit a spring
		position += Vector2(0, -(14)).rotated(rot)
		rot = 0
		up_direction = Vector2(0, -1)
		# Set your Rotation and Up Direction to their defaults and moves you away from the ceiling
	elif gettinghurt and abs(slopefactor) == 1: #if you are on a wall and get hurt
		rot = 0
		up_direction = Vector2(0, -1)
		# Set your Rotation and Up Direction to their defaults.
	elif abs(rot) > 1 and gettinghurt: #if you are on the ceiling and get hurt
		position += Vector2(0, -(14)).rotated(rot)
		rot = 0
		up_direction = Vector2(0, -1)
		# Set your Rotation and Up Direction to their defaults and moves you away from the ceiling
	elif death:
		position += Vector2(0, -(14)).rotated(rot)
		rot = 0
		up_direction = Vector2(0, -1)
		# Set your Rotation and Up Direction to their defaults and moves you away from the ceiling





# Gravity
	if not is_on_floor() and rot == 0 and !gravityreversed: 
		motion.y += GRAVITY * delta
		# The basic Gravity procedure.
		# We only trigger this if you're in the air. Otherwise, your vertical motion- 
		# -would try to increase infinitely while you're on the ground.
	elif death: #keeps gravity even when you die
		motion.y += GRAVITY * delta
	elif gettinghurt and !gravityreversed: #keeps gravity when you get hurt
		motion.y += GRAVITY * delta
	elif gravityreversed:
		motion.y += -(GRAVITY * delta)
	elif !spring and !death and !gettinghurt:
		if abs(slopefactor) == 1 and !spring: # If running up a perfectly vertical wall...
			motion.y = 0
			# This makes sure you don't get any unwanted horizontal air speed when- 
			# -riding a perfectly U-shaped crevice. (Most of the time, at least.)
			# Without this, the motion addition below would cause you to drift off to-
			# -the side after launching yourself upwards.
		elif !spring and !death and !gettinghurt and !gravityreversed:
			motion.y = 50
			
		elif !spring and !death and !gettinghurt and gravityreversed:
			motion.y = -50
			# This tries to help you stick to the ground, though it's not very-
			# -effective at high speeds.
	
#spring match
	#checks which spring or other source you are currently in the vicinity of and applies velocity accordingly
	
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
				motion.y += -motion.y
				motion.x += -motion.x * 0.6
				spring = false
				canjump = false		
		"gottenhurt": #does the same but handles everything in regards to you getting hurt
			if gettinghurt and ringcount > 0 and !shielded and !hasshield:#if you get hit
				spring = false
				if ringcount > 0 and !shielded: #and you have more than 0 rings
					$"sonic sfx/ringloss".play()
					position += Vector2(0, -(14)).rotated(rot)
					$timers/iframestime.start()
					iframes = true
					ringsflung = true
					ringcount = 0
					if facingleft and hurt:#moves you in the opposite direction you're facing and sets your rings to 0 
						motion.x += 300 
						motion.y = -150
						hurt = false
						
					if facingright and hurt:
						motion.x += -300 
						motion.y = -150
						hurt = false
				
						
						
			if ringcount == 0 and !shielded: #or if you have 0 rings
				if hurt: #you die
					death = true
					dead = true
					hurt = false
					gettinghurt = false
			if gettinghurt and shielded:
				if shielded: #or you have a shield
					
					position += Vector2(0, -(14)).rotated(rot)
					$timers/iframestime.start()
					iframes = true
					
					shielded = false
					if facingleft and hurt:#moves you in the opposite direction you're facing and sets your rings to 0 
						motion.x += 300 
						motion.y = -150
						hurt = false
						
					if facingright and hurt:
						motion.x += -300 
						motion.y = -150
						hurt = false			
		"enemy bounce": #bounces you off of an enemy
			if bouncing and spring:
				canjump = false
				
				if ! grounded and jumping: #and !Input.is_action_pressed("jump"):
					motion.y = -JUMP_VELOCITY * 1.2 + -(abs(motion.x))#abs(motion.y) + abs(motion.x) * -40
				elif !grounded and !jumping:
					motion.y = -JUMP_VELOCITY + -(abs(motion.x))
					#motion.y += -400
					
				bouncing = false
				spring = false
					
		"bubble":
			if drowningreset and bubbleanim:
				motion.x = 0
				motion.y = 0				
	

# Jump

# You'd think a Jumping mechanic would be simple, right? 
# Just add -JUMP_VELOCITY when you press the Jump button while on the floor, and you're done.
# That would make sense, but in reality, it's just not that simple.
# Think of it this way: While the game has frame-perfect reaction time for every little thing, the-
# -PLAYER does not.
# For example, you might walk off a cliff for a single frame and THEN press the jump button.
# In that situation, the game will NOT be forgiving.
# It will only see that you're not on the ground, and will ignore the jump input accordingly,
# -causing you to fall down embarrasingly.

# To avoid this, let's make a forgiving Jump mechanic.


## First, we make sure every jump input gets buffered.
# This will let us detect a single jump input for several frames instead of just one.

# The intention for this is to make it so that if you press jump slightly before hitting the ground, 
# it'll execute the jump the moment you land.

	if Input.is_action_just_pressed("jump") and !crouching and !spindashing and !death and !gettinghurt and !intube and !passedgoal and !levelstart and !bossstart and !bossdefeat and !cutscenedisable and !gimmickdisable:
		
		crouching = false
		spindashing = false
		jumpbuffered = true
		$timers/JumpBufferTimer.start()
		# When the Jump button is pressed, start buffering the jump.
		# In the same breath, let's start a timer. Once that timer runs out,
		# the jump will stop being buffered.
		
		## To see exactly what happens when this timer runs out, check near the very bottom of the script.

## Now for the Coyote Timer.

	if not grounded and canjump: # If you're not on the ground, but are still able to jump...
		if $timers/CoyoteTimer.is_stopped():
			$timers/CoyoteTimer.start()
			# Start the Coyote timer.
			## We must only start it if it's stopped.
			## Otherwise, it would just constantly restart itself before it even finishes.
	else:
		$timers/CoyoteTimer.stop()
		# If you're on the ground, or are already not able to jump, then there's no reason-
		# -for us to start the timer.

## Alright! Now let's actually execute the jump.

	if jumpbuffered and canjump  and !death and !spring and !bouncing: # If your jump input is detected and you're currently able to jump...
		$"sonic sfx/jumpsfx".play()
		if ballstate and abs(motion.x) > 650:
			motion.y = -JUMP_VELOCITY * 1.2
			ballstate = false
		else:
			motion.y = -JUMP_VELOCITY
			ballstate = false
		jumping = true
		
		# Jump.
		
		canjump = false
		# Then revoke your ability to jump. Don't worry, this will get reactivated once you land.
		## Without this part, you'd be able to fly up infinitely.
		
		
		if abs(rot) > 1: # If you're sideways or upside-down (on a wall or cieling)...
			position += Vector2(0, -(14)).rotated(rot)
			# Shift your position a bit away from the floor.
			## Because of the type of collision we're using,
			## getting stuck in a wall or ceiling is a big risk the player has.
			## This tries to prevent that from happening.
		
		
		$timers/JumpBufferTimer.stop()
		jumpbuffered = false
		# Once all that's done, we stop the timer from running out-
		# -so that we can deactivate the buffer manually.
		# We are no longer detecting that Jump input.


	if motion.y >= 0 and grounded: # If you're DEFINITELY on the ground...
		jumping = false
		canjump = true
		
		# Let the script know you're not jumping anymore, and return your ability to jump.


	if jumping and motion.y < -JUMP_VELOCITY / 1.625 and !spring and !gettinghurt and !death and !bouncing: # If your jumping motion goes beyond a certain point...
		if not Input.is_action_pressed("jump") and !death and !spring and !bouncing: # ...but you're NOT pressing the jump button anymore...
			motion.y = -JUMP_VELOCITY / 1.625
			# Set your vertical motion to that exact point.
			## Simply put, this lets you do high and low jumps depending on- 
			## -how long you press the button.and !death and !bossdefeat
	if Input.is_action_just_pressed("action3") and !grounded and !canjump and caninsta and !death and !gettinghurt and !intube and !passedgoal and !levelstart and !bossstart and !bossdefeat:
		instashield = true
		caninsta = false
		instatimer.start()
		$fx.visible = true
		$"sonic sfx/instasound".play()


# (Debug) Speed Boost
	#if Input.is_action_just_pressed("action"):
	#	motion.x += topspeed * sign($Sprite.scale.x)
	


# Movement
	var direction = Input.get_axis("left", "right") # Emits "-1" if holding left, and "1" if holding right.
	
	if $Sprite.scale.x == -1 and !spindashing and !dropdashing:
		facingleft = true
		facingright = false
	#updates your direction based on which way your sprite is facing	
	if $Sprite.scale.x == 1 and !spindashing and !dropdashing:
		facingleft = false
		facingright = true
	if bossstart and motion.x < 500:
		motion.x += 500
	if bossstart and motion.x >= 500:
		motion.x = 500
	if bossdefeat and motion.x < 560:
		motion.x += 560
		ballstate = false
	if bossdefeat and motion.x >= 560:
		motion.x = 560
	if direction and not control_lock and not ballstate and not crouching and !death and !gettinghurt and !intube and !passedgoal and !levelstart and !bossdefeat and !ispushing and !cutscenedisable and !gimmickdisable: # If holding left or right, and not slipping down a slope...
		if is_on_floor() and !spring: # If touching the floor...
			if direction == sign(motion.x): # If you're holding in the direction you're moving...
				if abs(motion.x) <= maxspeed: # If you're not over your Top Speed...
					motion.x += acc * direction
					# Accelerate in the direction you're holding.
					
			else: # If you're trying to turn around...
				if abs(slopefactor) < 0.4 and !intube and !icephysics: # If you're standing on flat or slightly slanted ground...
					motion.x += dec * direction
					if ($"sonic sfx/stoppingsfx").playing == false and abs(motion.x) > 350:
						$"sonic sfx/stoppingsfx".play()
					# Very quickly Deccelerate to a stop.
				if abs(slopefactor) < 0.4 and !intube and icephysics: # If you're standing on flat or slightly slanted ground...
					motion.x += (dec * direction) / 6
					
				elif !death and !intube: # If you're standing on a far too steep slope...
					motion.x += acc * direction
					# Turn at normal speed.
					## Logically, it would be pretty hard to slow down when running down a hill.
				
				
		elif !gettinghurt or !death: # If mid-air...
			if direction == sign(motion.x): # If you're holding in the direction you're moving...
				if abs(motion.x) <= topspeed: # If you're not over your Top Speed...
					motion.x += (acc * 2) * direction
					# Accelerate (a bit faster) in the direction you're holding.
					
			elif !death: # If you're trying to turn around...
				motion.x += (acc * 2) * direction
				# Deccellerate at the same speed.
			
			# Note: Due to logic, you can't quickly turn around mid-air.
			
	elif !spring and !death and !gettinghurt and !intube and !passedgoal: # If not pressing anything...
		if is_on_floor() and abs(slopefactor) < 0.25: # If you're on flat, or near-flat ground...
			motion.x = move_toward(motion.x, 0, acc)
			# Slow to a stop.
			## We shouldn't be able to stand perfectly still on a steep slope, right? Right.
	elif death and !passedgoal:
		motion.x = 0
	elif passedgoal:
		ballstate = false
		motion.x += 20
	elif bossdefeat:
		ballstate = false
		motion.x = 550
	
		




# Set Velocity to the Motion variable, but rotated.
	velocity = Vector2(motion.x, motion.y).rotated(rot)
	
	# Right here's where the magic happens.
	# Since Velocity is a Vector2, we've cleverly created a separate Vector2 called "Motion" to-
	# -take all the commands that Velocity would normally take, to then give it right back to-
	# -Velocity with an added ".rotated()" function, which effortlessly rotates Motion based on
	# -your actual rotation, therefore letting you run up walls and stuff.
#dropdash
	if Input.is_action_pressed("action") and !grounded and ! dropdashcool and !airdashing and !death and !gettinghurt and !cutscenedisable and !gimmickdisable:
		dropdashing = true #if you hold the action button, charge up your dropdash
		canjump = false
		if $"sonic sfx/spindashsfx".playing == false:
			$"sonic sfx/spindashsfx".play()
	if Input.is_action_just_released("action") and !grounded:#if you release the dropdash before touching the ground
		dropdashing = false
		$"sonic sfx/spindashsfx".stop()
		
		
	#if you touch the ground and you are still holding the button	
	if grounded and dropdashing  and !death and !gettinghurt and !passedgoal and !bossdefeat and !cutscenedisable and !gimmickdisable:
		ballstate = true
		dropdashcool = true
		$"sonic sfx/dashrelease".play()
		if facingleft:#sends you in your current direction
			motion.x = dropdashspeed * -1 * acc
		if facingright:
			motion.x = dropdashspeed * 1 * acc
		dropdashing = false
		$timers/dropdashcooldown.start()
		
	
# rolling
	if Input.is_action_pressed("down") and abs(motion.x) > 1 and grounded and !death and !gettinghurt and !intube and !passedgoal and !bossdefeat and !bossstart and !cutscenedisable and !gimmickdisable:
		ballstate = true
		if $"sonic sfx/spindashsfx".playing == false:
			$"sonic sfx/spindashsfx".play()
	#if you hold down while you're moving, you roll into a ball
	
# crouching
	if Input.is_action_pressed("down") and abs(motion.x) < 1 and grounded and !death and !spring and !gettinghurt and !levelstart and !cutscenedisable and !gimmickdisable:
		crouching = true #if you hold down, you crouch
	if Input.is_action_just_released("down") and abs(motion.x) < 1 and grounded and crouching and !death and !gettinghurt:
		crouching = false 
		ballstate = false
	elif !Input.is_action_pressed("down") and abs(motion.x) < 1 and grounded and crouching and !death and !gettinghurt:
		crouching = false
		#if you let go of the button, stop crouching
		
# Spindashing
	if crouching and Input.is_action_just_pressed("action") and grounded and !death and !gettinghurt and !intube and !passedgoal and !bossdefeat and !cutscenedisable and !gimmickdisable:
		spindashing = true #if you're crouching and press the action button, you start spindashing
		$"sonic sfx/spindashsfx".play()
		if spindashspeed < spindashmaxspeed:#every press of the button
			spindashspeed += 120#increase the speed of the spindash
		elif spindashspeed >= spindashmaxspeed:
			spindashspeed = spindashmaxspeed #if max, keep it the same as max
	
	elif Input.is_action_just_released("down") and spindashing and grounded and !death and !gettinghurt and !passedgoal and !bossdefeat and !cutscenedisable and !gimmickdisable:
		ballstate = true #if you release the down button
		$"sonic sfx/dashrelease".play()
		#the spindash sends you in the direction you're facing
		if facingleft:
			motion.x += spindashspeed * -1 * acc
		if facingright:
			motion.x += spindashspeed * 1 * acc
		crouching = false
		spindashing = false
		spindashspeed = 0
		
#airdash
	if Input.is_action_just_pressed("action2") and !grounded and !dropdashing and !airdashreset and !death and !gettinghurt and !cutscenedisable and !gimmickdisable:
		airdashing = true #if you're in the air and press action 2
		airdashreset = true
		airdashanim = true
		ballstate = false
		
		
	if airdashing and !grounded and !death and !gettinghurt  and !cutscenedisable and !gimmickdisable: #sends you in the direction you're facing
		$"sonic sfx/airdash".play()
		$timers/airdashcooldown.start()
		if facingleft:
			motion.x = airdashspeed * -1 * acc
			motion.y = airdashup
		if facingright:
			motion.x = airdashspeed * 1 * acc
			motion.y = airdashup
		airdashing = false
		
		
#ballstate control	
		
	if ballstate and !is_on_floor() and !Input.is_action_pressed("down") and !bouncing:
		ballstate = false #if you're not on the ground and are not holding the down button, uncurl from a ball
		
	if ballstate and is_on_floor() and not stuck and not $Collision/WallCast.is_colliding() and !death and !gettinghurt:
		motion.x += (acc * 0.8) * slopefactor
		#if you are on a slope while in a ball, you roll along it
	
	elif ballstate and abs(motion.x) < 50 and !intube: #if you slow down enough while in a ball
		$timers/"ballstate timer".start() #start a timer
		
		
	if ballstate and abs(motion.x) > 1250 and !intube: #if you are going fast enough
		ballstate = false #uncurl from a ball
		
	if intube and ballstate and motion.x < 600 or intube and ballstate and motion.x > -600:
		if facingleft:
			motion.x = -600
		if facingright:
			motion.x = 600
	
	if intube:
		ballstate = true
		$Collision/crushdetectorstop.enabled = false
		$Collision/wallcrushing.enabled = false
	elif intube and ballstate:
		if facingleft and motion.x < -600 and motion.x > -1200:
			motion.x = -1200
		if facingright and motion.x > 600 and motion.x < 1200:
			motion.x = 1200
	elif !death and !dead and is_on_floor() and !bossstart:
		$Collision/crushdetectorstop.enabled = true
		$Collision/wallcrushing.enabled = true
	elif !is_on_floor() or bossstart:
		$Collision/crushdetectorstop.enabled = false
		$Collision/wallcrushing.enabled = false

	if !dead and !intube and is_on_floor() and $Collision/crushdetectorstop.is_colliding() and $Collision/Raycast.is_colliding() or !intube and $Collision/wallcrushing.is_colliding() and $Collision/WallCast.is_colliding():
		await get_tree().create_timer(0.1).timeout
		if $Collision/crushdetectorstop.is_colliding() and $Collision/Raycast.is_colliding() or $Collision/wallcrushing.is_colliding() and $Collision/WallCast.is_colliding():
			death = true
			dead = true
			$Collision/crushdetectorstop.enabled = false
			$Collision/wallcrushing.enabled = false
			$Collision/Raycast.enabled = false
			dying()
			jumping = false
			ballstate = false

# Slopes
	if is_on_floor() and not stuck and not $Collision/WallCast.is_colliding() and !gettinghurt and !spring and !death and !cutscenedisable and !gimmickdisable:
		motion.x += (acc * 2) * slopefactor
		# When you're moving down a slope, add more acceleration.
		# When you're moving up a slope, slow the player down.
		## This is what gives Momentum.acc = 1.8
		GRAVITY = 350
		airdashspeed = 600
		spindashmaxspeed = 800
		dropdashspeed = 700
		## Without this, running up walls would be too unnaturally easy.
	
	if grounded and abs(slopefactor) >= 0.5 and abs(motion.x) < 10 and !spring and !death and !gettinghurt and !intube and !cutscenedisable and !gimmickdisable: # 
		control_lock = true
		$timers/ControlLockTimer.start()
		# If you slow down too much on a steep slope, briefly remove the ability to move left and right.
		## This makes the player slip down the slope
	
	if grounded and abs(slopeangle) > 1.5 or spring and abs(slopeangle) > 1.5 and !death and !gettinghurt and !intube: # If you're on a wall...
		if abs(motion.x) < 285: # ...and you're moving too slow...
			falloffwall = true
			position += Vector2(0, -(14)).rotated(rot)
			canjump = false
			# Detatch from the wall.
			
			control_lock = true
			$timers/ControlLockTimer.start()
			# Briefly lock the player's controls.
			## We wouldn't want them to awkwardly re-attatch to the wall over and over again.
	elif spring or gettinghurt or death:
		falloffwall = true
	else:
		falloffwall = false
	
	



# Stoppers
	if is_on_ceiling() and not grounded: # If you bonk your head on the ceiling...
		if motion.y < 0: # If you're moving up...
			motion.y = 100
			ballstate = false
			# Get sent right back down.
	
	if is_on_wall() and $Collision/WallCast.is_colliding() and !grounded: # If you bump into a wall...
		motion.x = 0
		ballstate = false
	
	if is_on_wall() and $Collision/WallCast.is_colliding() and motion.x > againstwallmax and grounded and Input.get_axis("left", "right"): # If you bump into a wall...
		motion.x = 0
		ballstate = false
		# Stop moving.
	
	##pushing handling
	if is_on_wall() and $Collision/WallCast.is_colliding() and motion.x < againstwallmax and grounded and Input.get_axis("left", "right"):
		ispushing = true
		motion.x = 10 * direction
		
	else:
		ispushing = false
		
	
	
	if Global.pause:
		motion.x = motion.x /2
		motion.y = motion.y /2
	
	#controls your stats while underwater
	if underwater and !icephysics:
		dec = 45
		acc = 1.8
		GRAVITY = 350
		airdashspeed = 600
		spindashmaxspeed = 800
		dropdashspeed = 700
		
	if icephysics and !underwater:
		dec = 25
		acc = 2.4
		GRAVITY = 650
		airdashspeed = 300
		spindashmaxspeed = 400
		dropdashspeed = 350
		
	if icephysics and underwater:
		dec = 30
		acc = 1.8
		GRAVITY = 350
		airdashspeed = 600
		spindashmaxspeed = 800
		dropdashspeed = 700
		
	elif !underwater and !icephysics:
		dec = 30
		acc = 2
		GRAVITY = 650
		airdashspeed = 300
		spindashmaxspeed = 400
		dropdashspeed = 350
	
		
	if drowned:
		drowned = false
		dead = true
		death = true
		dying()
	
	if grounded and onIce:
		icephysics = true
		print("on ice")
		
	elif !grounded or !onIce:
		icephysics = false
	
	
	if shielded:
		shields.visible = true
	if !shielded:
		shields.visible = false
	
	if gravityreversed:
		pass	
		
		
	
	
	drowningres()
	storedvelocityf()	
	flashing()
	ringfling()
	collision()
	animate()
	#slope_failsafe()
	move_and_slide()




# That's the main part of the script done with.
# Now let's move on to extra functions and timer signals.

func drowningres():
	if drowningreset:
		print("drowningreset")
		drowntimerstarted = false	
		drowningtimerinit.stop()
		drowntimecountdown.stop()
		_3_sec.stop()
		Global.drownmusic = false
	if bubblesound and !bubblesoundplaying:
		bubblesoundplaying = true
		$"sonic sfx/bubble".play()
		

func storedvelocityf():
	if Global.pause and velocityapplied:
		velocityapplied = false
	
	if !Global.pause and velocityapplied:
		storedvelx = motion.x
		storedvely = motion.y
	
	if !Global.pause and !velocityapplied:
		motion.x += storedvelx
		motion.y += storedvely
		velocityapplied = true

func flashing():
	if iframes and !flashtime:
		flashingtim.start()
		flashtime = true
	elif !iframes:
		$Sprite.self_modulate.a = 255

func ringfling():
	maxringsspawn = currentrings #sets the maximum rings you can fling out based on your current rings
	if ringsflung and !hasshield:	#if you are flinging out your rings
		if ringsspawned < maxringsspawn  and gettinghurt: #if the amount spawned is less than the max
			print("ringflung")
			newringflungleft.global_position = shotleft.global_position #at the marker
			get_parent().add_child(newringflungleft.duplicate()) #spawn a ring
			
			ringsspawned += 1 #adds 1 to the amount of rings spawned
		elif ringsspawned == maxringsspawn: #if you've spawned the max rings
			ringsspawned = 0 #set all values to default
			currentrings = 0 #and sets your rings to 0
			ringsflung = false

func dying():
	if death and Global.lifecount > 0: #if you're dead and have more than 0 lives
		if dead: #lose a life
			gettinghurt = false
			hurt = false
			falloffwall = true
			grounded = false
			motion.y = -300
			motion.x = 0
			$"timers/lost life".start()
			Global.sonicdied = true
			dead = false
		
	elif death and Global.lifecount == 0: #if you have 0 lives
		if dead: #you game over
			motion.y = -300
			motion.x = 0
			grounded = false
			Global.gameover = true
			Global.sonicdied = true
			dead = false



func collision():
	if jumping and !death and !bossdefeat and !instashield or ballstate and !death and !bossdefeat and !instashield or spindashing and !death and !bossdefeat and !instashield :
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = false
		dealdamageball.disabled = false
		#if you are in a ball
		
	if crouching and !death and !bossdefeat and !instashield and !spindashing:
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = false
		dealdamageball.disabled = true
		#if you are crouching
		
	if jumping and iframes and !death and !bossdefeat and !instashield or ballstate and iframes and !death and !bossdefeat and !instashield or spindashing and iframes and !death and !bossdefeat and !instashield or crouching and iframes and !death and !bossdefeat and !instashield:
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = true
		dealdamageball.disabled = false
		#if you got hit and are in a ball
		
	elif iframes and !death and !bossdefeat:
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = true
		dealdamageball.disabled = true
		#if you got hit and arent in a ball
		
	elif !death and !jumping and !ballstate and !spindashing and !crouching and !bossdefeat and !instashield:
		takedmgnoball.disabled = false
		collisionchecker.disabled = false
		takedmgball.disabled = true
		dealdamageball.disabled = true
		#if you aren't in a ball or hit
		
	elif death and !bossdefeat:
		takedmgnoball.disabled = true
		collisionchecker.disabled = true
		takedmgball.disabled = true
		dealdamageball.disabled = true
		$Collision.disabled = true
			#if you died, all collision is disabled
			
	elif bossdefeat:
		takedmgnoball.disabled = true
		collisionchecker.disabled = true
		takedmgball.disabled = true
		dealdamageball.disabled = false
		
	if instashield and !death and !bossdefeat and !iframes:
		instashape.disabled = false
		takedmgnoball.disabled = true
		collisionchecker.disabled = false
		takedmgball.disabled = true
		dealdamageball.disabled = false
		
	if !instashield or grounded:
		instashape.disabled = true
		

# Animation
## We don't set the animations in the physics_process() code because that would be messy.

## Like the Amy sprites? I made them myself. Use them if you'd like, I don't care.
## Though, you're obviously intended to swap them out with your own (probably ripped) sprites.

## I mostly just did this part for some visual flair.
## Could you imagine how boring it would be if you were just a box sliding around?

## Anyway, I won't explain every line in this part, but I will explain some of it.

var idle := true
var idleset := false

func animate():
	if abs(motion.x) > 1: # If you're moving...
		$Sprite.scale.x = sign(motion.x)
		$fx.scale.x = sign(motion.x)
		$Collision.scale.x = sign(motion.x)
		# Set Sprite scale and Collision scale based your direction.
		# This is how the Sprite is able to turn when you move.
	
	
	if grounded:
		if abs(motion.x) < 1: # If you're standing still, or at least EXTREMELY CLOSE to standing still...
			$Sprite.speed_scale = 1
			# Reset the Speed Scale.
			
		elif abs(motion.x) < topspeed - 100 and !ballstate and !death and !intube: # If you're moving, but not at your Top Speed yet...
			$Sprite.play("walk")
			$Sprite.speed_scale = 0.2 + (abs(motion.x) / 550)
			# Play Walking Animation at half speed, quickening it as you move faster and faster.
			
		elif abs(motion.x) < maxspeed - 10 and !ballstate and !death and !intube: # If you've reached, or are at least close enough to your Top Speed...
			$Sprite.play("run")
			$Sprite.speed_scale = 1 + (abs(motion.x) /  750)
			
		elif !ballstate and !death and !intube:
			$Sprite.play("top speed")
			$Sprite.speed_scale = 1.5 + (abs(motion.x) / (maxspeed * 2))
			# Play Running Animation, quickening it even further if you escalate past your Top Speed.
			
		elif ballstate and !spindashing and !death or intube and ballstate and !spindashing and !death and !bubbleanim:
			$Sprite.play("jump")
			$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
			#if you aren't spindashing and are in ballstate, plays ball animation
		
		
	elif jumping and !airdashanim and !death and !gettinghurt and !bubbleanim:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
		#playes ball animation if you are jumping
	
	elif ballstate and !airdashanim and !death and !gettinghurt and !bubbleanim:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
		#playes jump if you are still in ball state
	
	#handles non ball state upwards and downwards acceleration animations
	
	elif !grounded and motion.y > 1 and !ballstate and abs(motion.x) < 650 and !dropdashing and !airdashanim and !death and !gettinghurt and !intube and !instashield and !bubbleanim:
		$Sprite.play("fall")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif !grounded and motion.y < 1 and !ballstate and abs(motion.x) < 650 and !dropdashing and !airdashanim and !death and !gettinghurt and !intube and !instashield and !bubbleanim:
		$Sprite.play("flight")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
	elif !grounded and !ballstate and abs(motion.x) > 650 and !dropdashing and !airdashanim and !death and !gettinghurt and !intube and !instashield and !bubbleanim:
		$Sprite.play("sideflight")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
		#if you are moving above a certain speed and are in the air, plays sideflight
	elif !grounded and ballstate and !airdashanim and !death and !gettinghurt and !bubbleanim:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
		#if you are curled into a ball, play the ball animation
	elif !grounded and dropdashing and !death and !gettinghurt and !bubbleanim:
		$Sprite.play("jump")
		$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
		#if you are dropdashing, play the ball animation
	elif airdashanim and !grounded and !dropdashing and !death and !gettinghurt and !intube  and !instashield:
		$Sprite.play("airdash")
	#plays the airdash animatiom
	if instashield and !bubbleanim:
		$Sprite.play("jump")
		$fx.play("instashield")
	
	elif intube:
		$Sprite.play("jump")
	
	elif bubbleanim:
		$Sprite.play("bubble")
		await get_tree().create_timer(1.0).timeout
		bubblesound = false
		bubblesoundplaying = false
		bubbleanim = false
	
	elif gettinghurt and !death:
		$Sprite.play("hurt")
		#plays hurt animation when you get hurt
	elif !gettinghurt and death:
		$Sprite.play("hurt")
		#plays death animation when you die
	
	
	
	# Idle animation
	
	if grounded and spindashing and abs(motion.x) < 1 and !death:
			$Sprite.play("spindashrev")
			$Sprite.speed_scale = 1 + (abs(motion.x) / (topspeed * 2))
			#if you are spindashing, plays spindashing animation
	
	if grounded and abs(motion.x) < 1 and crouching and !spindashing and !ballstate and !death:
		$Sprite.play("crouching")
		#if you are crouching, plays crouching animation
	
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
	# After a brief moment, your ability to move left and right is restored.

func _on_jump_buffer_timer_timeout():
	jumpbuffered = false
	# If you pressed jump but aren't close enough to the ground, it stops buffering your jump.

func _on_coyote_timer_timeout():
	canjump = false
	# If you've been in the air for too long, your ability to jump is revoked.

func _on_ballstate_timer_timeout() -> void:
	ballstate = false #after timer, uncurl from ball


func _on_dropdashcooldown_timeout() -> void:
	dropdashcool = false #allows you to dropdash again

func _on_takedamageboxnoball_area_entered(area: Area2D):
	if area.is_in_group("enemy"):	
		if ringcount > 0 or shielded:
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
		#detects if an enemy has entered your hurtbox and damages you
		#if you are at 0 rings, you die
	if area.is_in_group("damagearea") and !bouncing:
		if ringcount > 0 or shielded:
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
	hasshield = false
	#disables iframes

func _on_takedamageball_area_entered(area: Area2D):
	if area.is_in_group("enemy") and !bouncing:
		if ringcount > 0 or shielded:
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
	if area.is_in_group("damagearea") and !bouncing:
		if ringcount > 0 or shielded:
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
		
		#as is above, but in a ball
	#if area.is_in_group("ring"):
	#	ringcount + 1

func _on_dealdamage_area_entered(area: Area2D):
	#if area.is_in_group("ring"):
	#	ringcount + 1
	if area.is_in_group("enemy") and !gettinghurt:
		springtype = "enemy bounce"
		bouncing = true
		spring = true
	if area.is_in_group("box") and !gettinghurt:
		springtype = "enemy bounce"
		bouncing = true
		spring = true
	if area.is_in_group("eggman") and !gettinghurt:
		springtype = "bumper"
		spring = true

func _on_lost_life_timeout() -> void:
	if Global.currentlevelbossex:
		Global.sonicdied = false
		Global.bosslevelstart = true
		Global.died = true
		Progress.lifecount -= 1
		get_tree().reload_current_scene()
	else:
		Global.sonicdied = false
		Global.levelstarting = true
		Global.died = true
		Progress.lifecount -= 1
		get_tree().reload_current_scene()
	#after playing death animation, reloads the level

func _on_collisioncheckernoball_area_entered(area: Area2D):
	if area.is_in_group("kill"): #if you hit a kill plane, you die
		death = true
		dead = true
		shielded = false
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
	
	#checks if a spring is in you collision checker and the springtype variable to the type of spring and sets spring to true
	if area.is_in_group("ring"): #if you interact with a ring
		if !gettinghurt:#if you aren't getting hurt
			ringcount += 1
			print(ringcount)
		elif gettinghurt:#if you are getting hurt
			await get_tree().create_timer(1.0).timeout #wait 1 second
			ringcount += 1
			print(ringcount)
	if area.is_in_group("tube"):
		ballstate = true
		intube = true
		if !tubesfxplaying:
			$"sonic sfx/spindashsfx".play()
			tubesfxplaying = true
			
	if area.is_in_group("nodrown"):
		drowningreset = true
		
	if area.is_in_group("bubble"):
		drowningreset = true
		bubbleanim = true
		bubblesound = true
		springtype = "bubble"
	
		
func _on_airdashcooldown_timeout() -> void:
	airdashanim = false #disables air dash animation

func _on_collisioncheckernoball_area_exited(area: Area2D):
	if 	area.is_in_group("tube") and intube:
		intube = false
		ballstate = false
		tubesfxplaying = false
	if area.is_in_group("nodrown"):
		drowningreset = false
	if area.is_in_group("bubble"):
		drowningreset = false
		
	
func _on_drowningtimerinit_timeout() -> void:
	drowntimecountdown.start()
	Global.drownmusic = true


func _on_drowntimecountdown_timeout() -> void:
	drowned = true
	Global.diedunderwater = true


func _on_instatimer_timeout() -> void:
	instashield = false
	$fx.visible = false


func _on_instaball_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") and !gettinghurt:
		springtype = "enemy bounce"
		bouncing = true
		spring = true
	if area.is_in_group("box") and !gettinghurt:
		springtype = "bumper"
		spring = true
	if area.is_in_group("eggman") and !gettinghurt:
		springtype = "bumper"
		spring = true
		

func _on_flashing_timeout() -> void:
	if flashtime:	
		if opaque:
			$Sprite.self_modulate.a = 0
			opaque = false
			flashtime = false
		elif !opaque:
			$Sprite.self_modulate.a = 255
			opaque = true
			flashtime = false




# WARNING
## I tucked this part at the bottom of the script since this is just for a pretty rare scenario.
## Basically, if you ran down a slope that looks like THIS:
##
##                                |
## _ _ _ _ _ _ _ _ _ _ _ _        |
##                         \      |
##                           \    |
##                             \  |
##                       pass        \|
##
## ...You'll get trapped in the corner forever. And get stuck in the wall.
##  So... please don't do that.


# I tried to write a thing to fix this:
func slope_failsafe():
	if is_on_floor() and ($Collision/WallCast.is_colliding() and abs(rot) > 0.4):
		if abs(motion.x) > 100 and sign(rot) == sign(motion.x):
			stuck = true
			motion.x = -sign(slopefactor) * motion.x
			# It basically just reverses your movement if you get stuck.
	else:
		stuck = false
# ...but it kinda broke something else. So I disabled it. Oh well.





## Thanks for downloading.
## I made this because I was sick of there being no tutorials on how to make Sonic physics in Godot.
## Hope my comments were helpful.
## Have fun developing!!
## - Maddie
