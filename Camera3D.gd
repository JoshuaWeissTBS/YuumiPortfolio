extends Camera3D

@onready var target: CharacterBody3D = $"../PlayerController"
@export var offset: Vector3
@export var smooth_speed: float

func _physics_process(delta):
	transform.origin = lerp(transform.origin, target.transform.origin + offset, smooth_speed * delta)
