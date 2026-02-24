extends Node
class_name CmpScore

signal event(event_name: StringName, args: Array[Variant])

var points: float = 0.0:
	set(v):
		points = v
		emit_event("points_changed", [points])

func add_points(args: Array[Variant]) -> void:
	points += args[1]
	if owner is Player:
		Signals.points_changed.emit(points)

func emit_event(event_name: StringName, args: Array[Variant]) -> void:
	event.emit(event_name, args)
