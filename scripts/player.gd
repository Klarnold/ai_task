class_name Player
extends CharacterBody3D

@export var speed: float = 10.0 
@export var steering_amount: float = 6.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", 'right', "forward", "back")
	
	var desired_velocity: Vector3 = Vector3(direction.x, 0.0, direction.y) * speed
	var velocity_change: Vector3 = desired_velocity - velocity
	var steering_factor: float = delta * steering_amount
	velocity += velocity_change * min(1.0, steering_factor)
	
	if !is_on_floor():
		velocity.y -= gravity * delta * 5.0
	
	move_and_slide()
