extends CharacterBody2D
class_name Ball

@export var speed: float = 300.0

var game: Game = null

var rnd = RandomNumberGenerator.new()


func _ready() -> void:
	game = get_parent()
	reset()


func _physics_process(delta: float) -> void:
	var motion = velocity * delta
	var collision = move_and_collide(motion)
	if not collision:
		return
	print_debug("Collision!")
	var other = collision.get_collider()
	print_debug("Collision with: " + other.get_class())
	var collision_normal = game.get_collision_normal(other)
	print_debug("Collision normal: (" + str(collision_normal.x) + "; " + str(collision_normal.y) + ")")
	velocity *= collision_normal


func reset() -> void:
	position = Vector2(1920 / 2, 1080 / 2)
	var new_velocity = Vector2(-1.0, rnd.randf_range(-0.5, 0.5))
	velocity = new_velocity.normalized() * speed
	
