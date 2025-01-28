extends CharacterBody2D
class_name Player

@export var speed: float = 300.0
@export var action_up: String = "player_left_up"
@export var action_down: String = "player_left_down"


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis(action_up, action_down)
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = 0
	move_and_slide()
