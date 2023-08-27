extends Node3D
var collected_chapters = 0 # TODO: replace with cached
const MAX_CHAPTERS = 4 # TODO: replace with real amount
@onready var unplayed_collect_voicelines = [$Collect1, $Collect2, $Collect3]

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/LostChapterCollectionControl/LostChapterCollectionLabel.text = str(collected_chapters) + "/" + str(MAX_CHAPTERS)

func increment_collected_chapters():
	collected_chapters += 1
	if (collected_chapters == MAX_CHAPTERS):
		$CompletedPageCollection.play()
	$CanvasLayer/LostChapterCollectionControl/LostChapterCollectionLabel.text = str(collected_chapters) + "/" + str(MAX_CHAPTERS)

func play_collected_vo():
	if not unplayed_collect_voicelines.is_empty():
		var vo = unplayed_collect_voicelines.pick_random()
		vo.play()
		unplayed_collect_voicelines.erase(vo)
