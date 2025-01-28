extends Control

var menu_items: Dictionary
var active_menu_item: Enums.MenuItems = Enums.MenuItems.PVP
var tween: Tween = null

func _ready() -> void:
	menu_items = {
		Enums.MenuItems.PVP: $MenuItemStartPvP,
		Enums.MenuItems.PVE: $MenuItemStartPvE,
		Enums.MenuItems.QUIT: $MenuItemStartQuit
	}


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up", false):
		if active_menu_item > Enums.MenuItems.PVP:
			active_menu_item -= 1
			update_ui()
	if event.is_action_pressed("ui_down", false):
		if active_menu_item < Enums.MenuItems.QUIT:
			active_menu_item += 1
			update_ui()
	if event.is_action_pressed("ui_accept", false):
		match active_menu_item:
			Enums.MenuItems.PVP:
				Global.game_mode = active_menu_item
				get_tree().change_scene_to_file("res://Game.tscn")
			Enums.MenuItems.PVE:
				Global.game_mode = active_menu_item
				get_tree().change_scene_to_file("res://Game.tscn")
			Enums.MenuItems.QUIT:
				get_tree().quit()


func update_ui() -> void:
	if tween: tween.kill()
	tween = create_tween()
	for key in menu_items:
		var label: Label = menu_items[key]
		var alpha := 0.25
		if key == active_menu_item:
			alpha = 1.0
		tween.parallel().tween_property(label.label_settings, "font_color:a", alpha, 0.3)
	
