extends RigidBody2D

@export var snoc : Node2D

@export var ringbox = true
@export var lifebox = false
@export var shieldbox = false
@onready var primarycol: CollisionShape2D = $primarycol
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var playing = false
var broke = false
var givesonic = false
var notgiven = true
@onready var breakzone: Area2D = $breakzone
@onready var break_z: CollisionShape2D = $breakzone/breakZ
@onready var breaking_sfx: AudioStreamPlayer = $sounds/breakingSFX
@onready var ringgetsfx: AudioStreamPlayer = $sounds/ringgetsfx
@onready var lifegetsfx: AudioStreamPlayer = $sounds/lifegetsfx
@onready var shieldgetsfx: AudioStreamPlayer = $sounds/shieldgetsfx

func _physics_process(delta: float) -> void:
	
	
	if ringbox and !playing:
		sprite.play("rings")
		playing = true
	if lifebox and !playing:
		sprite.play("life")
		playing = true
	if shieldbox and !playing:
		sprite.play("shield")
		playing = true
	

	if broke and !givesonic:
		broke = false
		givesonic = true
		primarycol.disabled = true
		break_z.disabled = true
		sprite.play("broken")
		breaking_sfx.play()
		print("giving sonic")
	

	if givesonic and ringbox and notgiven:
		ringgetsfx.play()
		notgiven = false
		snoc.ringcount += 10
		
		print("10 rings")
	elif givesonic and lifebox and notgiven:
		lifegetsfx.play()
		notgiven = false
		Progress.lifecount += 1
		
		print("1 life")

	elif givesonic and shieldbox and notgiven:
		shieldgetsfx
		notgiven = false
		snoc.shielded = true
		snoc.hasshield = true
		print("shielded")

func _on_breakzone_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerdeal") and !broke:
		print("itembroken")
		broke = true
