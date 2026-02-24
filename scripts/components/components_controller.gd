extends Node3D
class_name ComponentsController

var components: Array[Node]

func _ready() -> void:
	for child in get_children():
		child.event.connect(handle_event)
		components.append(child)

func handle_event(event_name: StringName, args: Array[Variant] = []) -> void:
	for cmp in components:
		if cmp.has_method(event_name):
			cmp.call(event_name, args) 
