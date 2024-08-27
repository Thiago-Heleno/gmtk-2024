extends Node2D

@export var MIN_WINDOW_SIZE: float = 0.25


func _ready() -> void:
	get_viewport().transparent_bg = true
	GameManager.gameOver = true


func _on_main_menu_btn_pressed() -> void:
	GameManager.play_click_sound()
	GameManager.start_time = 0
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pass # Replace with function body.
