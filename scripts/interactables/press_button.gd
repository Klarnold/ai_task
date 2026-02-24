extends Area3D
class_name PressButton

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

@export var activated: bool = false
@export var linked_entity: InterativeEntity

func _activate() -> void:
	if linked_entity != null:
		linked_entity.use()
	if !activated:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", -0.1, 0.5)
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", 0.0, 0.5)
	activated = !activated

func _on_body_entered(_body: Node3D) -> void:
	if !activated:
		_activate()

func _on_body_exited(_body: Node3D) -> void:
	if activated:
		_activate()
