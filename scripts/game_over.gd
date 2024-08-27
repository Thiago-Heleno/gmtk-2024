extends Node2D

@export var MIN_WINDOW_SIZE: float = 0.25


func _ready() -> void:
	GameManager.gameOver = true
	get_viewport().transparent_bg = true


func _on_restart_level_btn_pressed() -> void:
	GameManager.gameOver = false
	GameManager.play_restart_sound()
	GameManager.start_time = 0
	GameManager.current_level = 1
	get_tree().change_scene_to_file("res://scenes/game1.tscn")


func _on_main_menu_btn_pressed() -> void:
	GameManager.play_click_sound()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pass # Replace with function body.
