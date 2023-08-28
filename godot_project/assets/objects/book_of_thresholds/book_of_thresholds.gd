extends Node3D
@export var player_controller: PlayerController

func set_book_content_texture(texture: CompressedTexture2D):
	$Sprite3D.texture = texture

func close_book():
	$AnimationTree.set("parameters/Transition/transition_request", "close")
	player_controller.in_book = false
	_play_close_book_vo()
	

var rng = RandomNumberGenerator.new()
func _play_close_book_vo():
	await get_tree().create_timer(0.5).timeout
	if $"../../Collect1".playing or $"../../Collect2".playing or $"../../Collect3".playing:
		return
	if rng.randi_range(0, 3) > 0:
		$CloseBookVO.play()
