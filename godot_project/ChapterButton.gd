extends TextureButton
class_name ChapterButton

@export var lostChapter: LostChapter 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lostChapter.collected:
		disabled = false
	else:
		disabled = true


func _on_pressed():
	pass
#	print("open book")
#	$"../../".close_menu()
#	lostChapter.open_book()


func _on_button_up():
	print("open book")
	$"../../".close_menu()
	lostChapter.open_book()
