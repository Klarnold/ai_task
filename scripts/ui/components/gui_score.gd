extends Control
class_name GuiScore

@onready var score_label: Label = %score_label

func _ready() -> void:
	Signals.points_changed.connect(set_score)

func set_score(score: float) -> void:
	score_label.text = "points: %s" % snappedf(score, 0.1)
