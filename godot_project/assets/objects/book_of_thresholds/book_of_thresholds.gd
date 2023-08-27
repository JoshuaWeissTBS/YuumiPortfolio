extends Node3D
@export var player_controller: PlayerController

func set_book_content_texture(texture: CompressedTexture2D):
	$Sprite3D.texture = texture

func close_book():
	$AnimationTree.set("parameters/Transition/transition_request", "close")
	player_controller.in_book = false
