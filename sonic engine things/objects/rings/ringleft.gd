extends RigidBody2D
@onready var ringshape: CollisionShape2D = $"ring collision/ringshape"
var collected = false
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var rngx = RandomNumberGenerator.new()
var rngy = RandomNumberGenerator.new()
var rngxdir = RandomNumberGenerator.new()

var yvel
var xvel
var xdirec

var xvelocityapplied = false
var yvelocityapplied = false

var ringspawned = false

func _ready():
	#randmoizes the velocity of the rings
	yvel = rngy.randi_range(3,100)
	xvel = rngx.randi_range(2, 200)
	xdirec = rngxdir.randi_range(1,2)
	if !ringspawned:
		await get_tree().create_timer(0.5).timeout
		ringshape.disabled = false
		ringspawned = true
func _process(delta: float):
	
	
	ringcollect()
	
func _physics_process(delta: float):
	#applies the velocity to the rings
	if xdirec == 1 and !xvelocityapplied:
		linear_velocity.x += -xvel
		xvelocityapplied = true
	elif xdirec == 2 and !xvelocityapplied:
		linear_velocity.x += xvel
		xvelocityapplied = true
	if !yvelocityapplied:
		linear_velocity.y += -yvel
		yvelocityapplied = true
	#if xvelocityapplied and yvelocityapplied:
	#	linear_velocity.x = 0
	#	linear_velocity.y = 0
 
	
func ringcollect():
	if collected: #if you collect this ring
		ringshape.disabled = true #disable collision
		collision_shape_2d.disabled = true
		freeze = true #freeze it in place
		animated_sprite_2d.play("ringcollected")
		$ring.play() #play the sound effect and collection animation
		$"disappear timer".start() #start timer for it to disappear
		collected = false

func _on_ring_collision_area_entered(area: Area2D):
	if area.is_in_group("player"): #if a player is in the vicinity, collect the ring
		collected = true


func _on_disappear_timer_timeout() -> void:
	queue_free()


func _on_autodisappear_timeout() -> void:
	queue_free()
