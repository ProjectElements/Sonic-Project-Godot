extends Node2D
@onready var bubblespawnplace: Marker2D = $Marker2D

@export var thebubble = load("res://sonic engine things/objects/level chunks or mechanics/bubble.tscn")

var bubblespawn = thebubble.instantiate()

var bubblespawned = true
@onready var spawntime: Timer = $spawntime

func _physics_process(delta: float) -> void:
	if bubblespawned:
		bubblespawned = false
		spawntime.start()

func _on_spawntime_timeout() -> void:
	bubblespawned = true
	bubblespawn.global_position = bubblespawnplace.global_position 
	get_parent().add_child(bubblespawn.duplicate())
