extends Node2D

@onready var click_sound: AudioStreamPlayer2D = $click_sound
@onready var soundtrack: AudioStreamPlayer2D = $soundtrack
@onready var power_up: AudioStreamPlayer2D = $power_up
@onready var restart_sound: AudioStreamPlayer2D = $restart_sound

var current_level: int = 1
var start_time: int = 0
var gameOver: bool = false
var elapsedTime = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	soundtrack.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_click_sound():
	click_sound.playing = true
	
func play_restart_sound():
	restart_sound.playing = true

func load_next_level(level: String):
	get_tree().change_scene_to_file("res://scenes/game" + level + ".tscn")
	
func increase_level():
	current_level += 1
	power_up.playing = true
	if current_level >= 8:
		get_tree().change_scene_to_file("res://scenes/win_menu.tscn")
	else:
		load_next_level(str(current_level))
	
