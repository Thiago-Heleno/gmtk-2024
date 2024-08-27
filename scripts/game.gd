extends Node2D

@export var MIN_WINDOW_SIZE: float = 0.25

@onready var border: Control = $Border


@onready var timer: Timer = $Timer
@onready var sub_viewport_container: SubViewportContainer = $SubViewportContainer
@onready var sub_viewport: SubViewport = $SubViewportContainer/SubViewport

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
var drag_offset2: Vector2 = Vector2.ZERO




func _ready() -> void:
	timer.start()
	get_viewport().transparent_bg = true
	if GameManager.current_level == 1:
		GameManager.start_time = Time.get_ticks_msec()

func _process(delta: float) -> void:
	var original_size = border.get_size()
	var effective_size = original_size * border.scale
	
	sub_viewport_container.size = effective_size
	sub_viewport.size = effective_size
	
	if is_dragging:
		# Update the position of the border to follow the mouse
		border.position = get_viewport().get_mouse_position() - drag_offset
		sub_viewport_container.position = get_viewport().get_mouse_position() - drag_offset2
	


func _on_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	smooth_transform(border.scale - Vector2(0.1, 0.1), 1.0, "scale")
	
	#animation_player.play("change_viewport_size")
	
	if(border.scale.x < MIN_WINDOW_SIZE):
		GameManager.play_restart_sound()
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	timer.start()
	#border.scale = border.scale - Vector2(10,10);
	pass # Replace with function body.


#window drag
func _on_drag_window_btn_button_down() -> void:
	is_dragging = true
	drag_offset = get_viewport().get_mouse_position() - border.position
	drag_offset2 = get_viewport().get_mouse_position() - sub_viewport_container.position

func _on_drag_window_btn_button_up() -> void:
	is_dragging = false
	
	
# Function to smoothly scale the border
func smooth_transform(target_scale: Vector2, duration: float, transform_type: String) -> void:
	var tween = get_tree().create_tween()
	# Start tween animation with an easing style
	tween.tween_property(border, transform_type, target_scale, duration).set_trans(Tween.TRANS_EXPO)
	
func add_time():
	timer.stop()
	smooth_transform(border.scale + Vector2(0.125, 0.125), 1.0, "scale")
	timer.start()


func _on_restart_level_btn_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.
