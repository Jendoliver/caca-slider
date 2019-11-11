extends CanvasLayer

signal play_again_pressed

var lose_phrases = [
	"You lose, very sad :(",
	"Beware the wall, punk",
	"RIP"
]
var score = 0 setget set_score
var hiscore = 0 setget set_hiscore

onready var lose_phrase_label: Label = $Background/LosePhraseLabel
onready var score_label: Label = $Background/ScoreLabel
onready var hiscore_label: Label = $Background/HiscoreLabel


func _ready():
	lose_phrase_label.text = lose_phrases[randi() % len(lose_phrases)]


func _on_PlayAgainBtn_pressed():
	emit_signal("play_again_pressed")
	queue_free()


func set_score(new_score):
	score = new_score
	score_label.text = str(score)


func set_hiscore(new_hiscore):
	hiscore = new_hiscore
	hiscore_label.text = str(hiscore)
