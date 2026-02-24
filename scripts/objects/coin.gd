class_name Coin
extends Area3D

@export var speed: float = 0.1
@export var steering_amount: float = 8.0
@export var points: float = 5.0
@export var rotation_speed: float = 3.5

var target: Area3D
var _velocity: Vector3

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
	rotation_speed += randf_range(-1.5, 1.5)

func _physics_process(delta: float) -> void:
	var desired_velocity: Vector3 = global_position.direction_to(target.global_position) * speed * delta if target != null else Vector3.ZERO
	_velocity += desired_velocity * min(delta * steering_amount, 1.0)
	translate_object_local(_velocity)
	#rotate_y(delta * rotation_speed)
	

func _on_body_entered(body: Node3D):
	if body is Player:
		pass # TODO добавление очков

func _on_area_entered(area: Area3D) -> void:
	if target != null:
		return
	target = area

func _on_area_exited(_area: Area3D) -> void:
	var areas: Array[Area3D] = get_overlapping_areas()
	var min_distance: float = INF
	if areas.is_empty():
		target = null
		return
		
	for area in areas:
		if global_position.distance_to(area.global_position) < min_distance:
			target = area
			min_distance = global_position.distance_to(area.global_position)

func give_points(reciever: Node3D) -> void:
	reciever.points += points
	destroy()

func destroy() -> void:
	call_deferred("queue_free")
