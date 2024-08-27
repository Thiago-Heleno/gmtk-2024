extends Node2D

@export var MIN_WINDOW_SIZE: float = 0.25
@onready var how_to_play_panel_2: Control = $Border/Menu2/HowToPlayPanel2
@onready var return_btn: Button = $Border/Menu2/HowToPlayPanel2/ReturnBtn
@onready var how_to_play_panel_3: Control = $Border/Menu2/HowToPlayPanel3


func _ready() -> void:
	get_viewport().transparent_bg = true
	GameManager.start_time = 0
	GameManager.current_level = 1


func _on_play_btn_pressed() -> void:
	GameManager.play_click_sound()
	GameManager.gameOver = false
	#get_tree().change_scene_to_file("res://scenes/game" + str(GameManager.current_level) + ".tscn")	
	get_tree().change_scene_to_file("res://scenes/game1.tscn")	


func _on_how_to_play_btn_pressed() -> void:
	how_to_play_panel_2.visible = true
	GameManager.play_click_sound()


func _on_return_btn_pressed() -> void:
	how_to_play_panel_2.visible = false
	how_to_play_panel_3.visible = false
	GameManager.play_click_sound()


@onready var video_stream_player: VideoStreamPlayer = $Border/Menu2/HowToPlayPanel3/VideoStreamPlayer
func _on_next_page_pressed() -> void:
	how_to_play_panel_2.visible = false
	video_stream_player.stop()
	video_stream_player.play()
	how_to_play_panel_3.visible = true
	GameManager.play_click_sound()
