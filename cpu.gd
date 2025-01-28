extends CharacterBody2D

@export var speed: float = 300.0

@onready var game: Game = $".."

func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	var y_diff = game.ball.position.y - position.y
	if y_diff < -10.0:
		direction = Vector2.UP
	elif y_diff > 10.0:
		direction = Vector2.DOWN
	velocity = direction * speed	
	move_and_slide()
