extends Control

@onready var border: Control = $"."

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var drag_offset2: Vector2 = Vector2.ZERO
@onready var elapsed_time_label: Label = $BorderImg/ElapsedTimeLabel


var sub_viewport_container = null

func _ready() -> void:
	var target_node = get_tree().root.get_node("Node2D/SubViewportContainer")
	if target_node:
		sub_viewport_container = target_node
	get_viewport().transparent_bg = true

func _process(delta: float) -> void:
	if GameManager.gameOver:
		elapsed_time_label.text = GameManager.elapsedTime
	if GameManager.start_time != 0 and GameManager.gameOver == false:
		var elapsed_time = Time.get_ticks_msec() - GameManager.start_time
		# Convert elapsed time into minutes, seconds, and milliseconds
		var minutes = int(elapsed_time / 60000)
		var seconds = int((elapsed_time % 60000) / 1000)
		var milliseconds = int(elapsed_time % 1000)
		# Format the time as MM:SS:MS
		var formatted_time = "%02d:%02d:%03d" % [minutes, seconds, milliseconds]
		GameManager.elapsedTime = formatted_time
		elapsed_time_label.text = str(formatted_time)
	if is_dragging:
		# Update the position of the border to follow the mouse
		border.position = get_viewport().get_mouse_position() - drag_offset
		if sub_viewport_container:
			sub_viewport_container.position = get_viewport().get_mouse_position() - drag_offset2
	

#window drag
func _on_drag_window_btn_button_down() -> void:
	is_dragging = true
	drag_offset = get_viewport().get_mouse_position() - border.position
	if sub_viewport_container:
		drag_offset2 = get_viewport().get_mouse_position() - sub_viewport_container.position

func _on_drag_window_btn_button_up() -> void:
	is_dragging = false
	
func _on_restart_level_btn_pressed() -> void:
	GameManager.play_restart_sound()
	get_tree().change_scene_to_file("res://scenes/game1.tscn")
	GameManager.start_time = 0
	GameManager.current_level = 1
	#get_tree().reload_current_scene()


func _on_close_game_btn_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_game_over_restart_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game" + str(GameManager.current_level) + ".tscn")
	pass # Replace with function body.


func _on_game_over_menu_btn_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pass # Replace with function body.


func _on_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	GameManager.play_click_sound()
