extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speedscale = 1.0

@onready var path: PathFollow2D = $PathFollow2D
@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if not loop:
		animation.play("plat")
		animation.speed_scale = speedscale
		set_process(false)

func _physics_process(delta: float) -> void:
	path.progress += speed
	
	
