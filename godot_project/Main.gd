extends Node3D
var collected_chapters = 0 # TODO: replace with cached
const MAX_CHAPTERS = 8 # TODO: replace with real amount

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/LostChapterCollectionControl/LostChapterCollectionLabel.text = str(collected_chapters) + "/" + str(MAX_CHAPTERS)

func increment_collected_chapters():
	collected_chapters += 1
	$CanvasLayer/LostChapterCollectionControl/LostChapterCollectionLabel.text = str(collected_chapters) + "/" + str(MAX_CHAPTERS)
