extends CharacterBody3D

const SPEED = 5.0

#func turn_towards(target_direction: Vector3, max_angular_speed: float, delta):
#	# face the direction smoothly
#	var local_target_direction: Vector3 = $Player.to_local($Player.global_transform.origin + target_direction)
#	var angle_to_target = atan2(local_target_direction.x, local_target_direction.z)
#	var movement_animation_tween = get_tree().create_tween()
#	var current_rotation: Quaternion = $Player.global_transform.basis.get_rotation_quaternion()
#	var max_rotation_angle = delta * max_angular_speed
#	var max_rotation: Quaternion = Quaternion(Vector3.UP, max_rotation_angle * sign(angle_to_target))
#	if abs(angle_to_target) >= abs(max_rotation_angle): # I feel like there should be a bug on this line, but I can't see it happening if it is.
#		$Player.transform.basis = Basis(current_rotation * max_rotation)
#	else:
#		$Player.transform.basis = Basis(current_rotation * Quaternion(Vector3.UP, angle_to_target))


func _physics_process(delta):
	$Shadow.global_position = $RayCast3D.get_collision_point() + Vector3(0, 0.15, 0)
	
	var direction = global_position.direction_to($"../PlayerController".global_position + Vector3(0, 4, 0))

	if global_position.distance_to($"../PlayerController".global_position + Vector3(0, 4, 0)) > 5:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, 0.15)
		velocity.y = move_toward(velocity.y, direction.y * SPEED, 0.15)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, 0.15)
	else:
		velocity.x = move_toward(velocity.x, 0, 0.05)
		velocity.y = move_toward(velocity.y, 0, 0.05)
		velocity.z = move_toward(velocity.z, 0, 0.05)
#	turn_towards(direction, MAX_ROTATE_SPEED, delta)
	$Shadow.global_position = $RayCast3D.get_collision_point() + Vector3(0, 0.1, 0)

	move_and_slide()

