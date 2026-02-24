extends Area3D
class_name Lever

@export var interative_entity: InterativeEntity
@export var activated: bool = false

@onready var _pivot_point_marker: Marker3D = %pivot_point_marker
@onready var _label_3d: Label3D = %label_3D
@onready var _animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("interact"):
			_use_requested()

func _use_requested() -> void:
	if interative_entity != null:
		interative_entity.use()
	if !activated:
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(_pivot_point_marker, "rotation:z", -PI / 6.0, 1.0)
	else:
		var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(_pivot_point_marker, "rotation:z", PI / 6.0, 1.0)
	activated = !activated

func _on_body_entered(_body: Node3D) -> void:
	_animation_player.play("show")

func _on_body_exited(_body: Node3D) -> void:
	_animation_player.play("hide")
