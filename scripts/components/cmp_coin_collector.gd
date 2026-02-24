@tool
extends Area3D
class_name CmpCoinCollector

signal event(event_name: StringName, args: Array[Variant])

const Recievers = {
	"PLAYER" = 0b1000,
	"ENEMY" = 0b10,
}

@export var reciever: String = "PLAYER":
	set(v):
		reciever = v
		collision_mask = Recievers.get(reciever)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	reciever = reciever

func _on_area_entered(area: Area3D) -> void:
	if !(area is Coin):
		return
	if owner is Player:
		emit_event("add_points", [owner, 5.0])
	else:
		emit_event("add_points", [owner, 1.0])
	area.destroy()

func _validate_property(property: Dictionary) -> void:
	if property.name == "reciever":
		property.hint = PROPERTY_HINT_ENUM
		property.hint_string = ",".join(Recievers.keys())

func emit_event(event_name: StringName, args: Array[Variant]) -> void:
	event.emit(event_name, args)
