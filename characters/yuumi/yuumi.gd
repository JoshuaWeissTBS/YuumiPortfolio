extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MAX_ROTATE_SPEED = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func turn_towards(target_direction: Vector3, max_angular_speed: float, delta):
	# face the direction smoothly
	var local_target_direction: Vector3 = $Player.to_local($Player.global_transform.origin + target_direction)
	var angle_to_target = atan2(local_target_direction.x, local_target_direction.z)
	var current_rotation: Quaternion = $Player.global_transform.basis.get_rotation_quaternion()
	var max_rotation_angle = delta * max_angular_speed
	var max_rotation: Quaternion = Quaternion(Vector3.UP, max_rotation_angle * sign(angle_to_target))
	if abs(angle_to_target) >= abs(max_rotation_angle): # I feel like there should be a bug on this line, but I can't see it happening if it is.
		$Player.global_transform.basis = Basis(current_rotation * max_rotation)
	else:
		$Player.global_transform.basis = Basis(current_rotation * Quaternion(Vector3.UP, angle_to_target))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#var quatDirection = Quaternion(dihow torection.x, direction.y, direction.z, 1)
	
	$AnimationTree.set("parameters/Walking/blend_position", input_dir)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	turn_towards(direction, MAX_ROTATE_SPEED, delta)

	move_and_slide()
