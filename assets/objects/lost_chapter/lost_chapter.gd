extends Node3D

@export var collected_tres: StandardMaterial3D
@export var uncollected_tres: StandardMaterial3D
@export var portfolio_info: PackedScene
var collected: bool = false # TODO: fetch collected state from local storage/cookies


func collect() -> PackedScene:
	# TODO: play sfx
	$"../Camera3D/BookOfThresholds/AnimationTree".set("parameters/Transition/transition_request", "open")
	$AnimationTree.set("parameters/Collected/transition_request", "collected")
	
	# Override materials
	$Node3D/Plane.material_override = collected_tres
	$Node3D/Plane_001.material_override = collected_tres
	$Node3D/Plane_002.material_override = collected_tres
	$Node3D/Plane_003.material_override = collected_tres
	
	# Hide outline
	$Node3D/Plane/MeshInstance3D.visible = false
	$Node3D/Plane_001/MeshInstance3D.visible = false
	$Node3D/Plane_002/MeshInstance3D.visible = false
	$Node3D/Plane_003/MeshInstance3D.visible = false
	
	# Stop particles and dimmed light
	$Node3D/GPUParticles3D.emitting = false
	$Node3D/OmniLight3D.omni_range = 2.0
	
	return portfolio_info
