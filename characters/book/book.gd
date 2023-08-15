extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("hovering")


func _physics_process(delta):
	$Shadow.global_position = $RayCast3D.get_collision_point() + Vector3(0, 0.15, 0)
