extends CharacterBody3D

const SPEED = 7.0

func turn_towards_player():
	var global_pos = global_transform.origin
	var player_pos = $"../PlayerController".global_transform.origin
	var rotation_speed = 0.05
	var wtransform = global_transform.looking_at(Vector3(player_pos.x,global_pos.y,player_pos.z),Vector3(0,1,0))
	var wrotation = Quaternion(global_transform.basis).slerp(Quaternion(wtransform.basis), rotation_speed)
	global_transform = Transform3D(Basis(wrotation), transform.origin)

func _physics_process(delta):
	var direction = position.direction_to($"../PlayerController".position + Vector3(0, 4, 0))

	if position.distance_to($"../PlayerController".position + Vector3(0, 4, 0)) > 7:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, 0.15)
		velocity.y = move_toward(velocity.y, direction.y * SPEED, 0.15)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, 0.15)
	else:
		velocity.x = move_toward(velocity.x, 0, 0.08)
		velocity.y = move_toward(velocity.y, 0, 0.08)
		velocity.z = move_toward(velocity.z, 0, 0.08)
	
	$"AnimationTree".set("parameters/MovementBlend/blend_amount", clamp(velocity.length() / 7, 0, 2))
	turn_towards_player()

	move_and_slide()

