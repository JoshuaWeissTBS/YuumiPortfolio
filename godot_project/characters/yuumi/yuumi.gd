extends CharacterBody3D
class_name PlayerController

const collected_chapters = 0 # TODO: replace with 
const MAX_CHAPTERS = 8 # TODO: replace with real amount
const SPEED = 10.0
const MAX_ROTATE_SPEED = 5
var in_book = false
var in_collection_menu = false

# interactions
var interacted_with_tree = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func turn_towards(target_direction: Vector3, max_angular_speed: float, delta):
	# face the direction smoothly
	var local_target_direction: Vector3 = $Player.to_local($Player.global_transform.origin + target_direction)
	var angle_to_target = atan2(local_target_direction.x, local_target_direction.z)
	var movement_animation_tween = get_tree().create_tween()
	var current_rotation: Quaternion = $Player.global_transform.basis.get_rotation_quaternion()
	movement_animation_tween.tween_property($AnimationTree, "parameters/Walking/blend_position", Vector2(-angle_to_target, target_direction.length()), 0.24)
	var max_rotation_angle = delta * max_angular_speed
	var max_rotation: Quaternion = Quaternion(Vector3.UP, max_rotation_angle * sign(angle_to_target))
	if abs(angle_to_target) >= abs(max_rotation_angle): # I feel like there should be a bug on this line, but I can't see it happening if it is.
		$Player.transform.basis = Basis(current_rotation * max_rotation)
	else:
		$Player.transform.basis = Basis(current_rotation * Quaternion(Vector3.UP, angle_to_target))

func close_book():
	$"../Camera3D/BookOfThresholds".close_book()
	var tween = get_tree().create_tween()
	tween.tween_property($"../CanvasLayer/Label", "modulate", Color.TRANSPARENT, 1)

func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		if in_book:
			close_book()
		elif in_collection_menu:
			$"../CanvasLayer/ChapterCollectionControl/ChapterCollection".close_menu()
			in_collection_menu = false
	if event.is_action_pressed("collection"):
		if in_book:
			close_book()
			$"../CanvasLayer/ChapterCollectionControl/ChapterCollection".open_menu()
			in_collection_menu = true
		elif in_collection_menu:
			$"../CanvasLayer/ChapterCollectionControl/ChapterCollection".close_menu()
			in_collection_menu = false
		else:
			$"../CanvasLayer/ChapterCollectionControl/ChapterCollection".open_menu()
			in_collection_menu = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	if (in_book or in_collection_menu):
		input_dir = Vector2.ZERO
		
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#var quatDirection = Quaternion(dihow torection.x, direction.y, direction.z, 1)

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 1)
		velocity.z = move_toward(velocity.z, 0, 1)
	
	turn_towards(direction, MAX_ROTATE_SPEED, delta)
	$Shadow.global_position = $RayCast3D.get_collision_point() + Vector3(0, 0.1, 0)
	
	if velocity.length() > 0 and velocity.y >= 0:
		if $Footsteps/TimeBetweenFootSteps.is_stopped():
			$Footsteps/TimeBetweenFootSteps.start()
	else:
		$Footsteps/TimeBetweenFootSteps.stop()

	move_and_slide()


func _on_lost_chapter_interaction_range_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if (area.is_in_group("LOST_CHAPTER")):
		var lost_chapter = area
		if not lost_chapter.collected:
			get_parent().increment_collected_chapters()
			lost_chapter.collect()
		else:
			lost_chapter.open_book()
	elif (area.is_in_group("TREE")) and not interacted_with_tree:
		interacted_with_tree = true
		$TreeInteractVO.play()


func _on_time_between_foot_steps_timeout():
	$Footsteps.play()
