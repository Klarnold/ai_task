extends InterativeEntity

var activated: bool = false

func use() -> void:
	if !activated:
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", PI / 2.0, 1.5)
	else:
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "rotation:y", 0.0, 1.5)
	activated = !activated
