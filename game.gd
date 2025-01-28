extends Node2D
class_name Game

@onready var player_right: CharacterBody2D = $PlayerRight
@onready var cpu: CharacterBody2D = $CPU
@onready var left_paddle: CharacterBody2D = $PlayerLeft
@onready var right_paddle: CharacterBody2D = null
@onready var upper_bounds: StaticBody2D = $UpperBounds
@onready var lower_bounds: StaticBody2D = $LowerBounds
@onready var ball: Ball = $Ball
@onready var label_score_left: Label = $UI/LabelScoreLeft
@onready var label_score_right: Label = $UI/LabelScoreRight

var score_left: int = 0
var score_right: int = 0


func _ready() -> void:
	match Global.game_mode:
		Enums.MenuItems.PVP:
			right_paddle = player_right
			cpu.queue_free()
		Enums.MenuItems.PVE:	
			right_paddle = cpu
			player_right.queue_free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func get_collision_normal(body: CollisionObject2D) -> Vector2:
	if body == left_paddle:
		return Vector2(-1.0, 1.0).normalized() * 1.5
	if body == right_paddle:
		return Vector2(-1.0, 1.0).normalized() * 1.5
	if body == upper_bounds:
		return Vector2(1.0, -1.0).normalized() * 2.0
	if body == lower_bounds:
		return Vector2(1.0, -1.0).normalized() * 2.0
	return Vector2.ZERO


func _on_left_goal_body_entered(body: Node2D) -> void:
	if body != ball: return
	score_right += 1
	label_score_right.text = str(score_right)
	ball.reset()


func _on_right_goal_body_entered(body: Node2D) -> void:
	if body != ball: return
	score_left += 1
	label_score_left.text = str(score_left)
	ball.reset()
