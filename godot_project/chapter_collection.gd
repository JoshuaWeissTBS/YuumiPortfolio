extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func open_menu():
	$AnimationPlayer.play("open")


func close_menu():
	$AnimationPlayer.play("close")


func _on_swift_by_knight_button_pressed():
	print("sbk")


func _on_paper_strategy_button_pressed():
	pass # Replace with function body.
