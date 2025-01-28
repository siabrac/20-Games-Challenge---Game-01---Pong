extends Node2D

@export var splash_screens: Array[PackedScene]

@onready var fader = $FaderLayer/Fader
@onready var current_splash = $CurentSplash

func _ready() -> void:
	for scene: PackedScene in splash_screens:
		for child in current_splash.get_children():
			current_splash.remove_child(child)
			child.queue_free()
		var splash = scene.instantiate()
		current_splash.add_child(splash)
		var tween = create_tween()
		tween.tween_property(fader, "color:a", 0.0, 1.0)
		tween.tween_interval(1.0)
		tween.tween_property(fader, "color:a", 1.0, 1.0)
		await tween.finished
	get_tree().change_scene_to_file("res://MainMenu.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")

	
