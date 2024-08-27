extends CharacterBody2D

@export var SPEED: float = 130.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep_sound: AudioStreamPlayer2D = $footstep_sound
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(delta: float) -> void:
	var direction_horizontal = Input.get_axis("move_left", "move_right")
	var direction_vertical = Input.get_axis("move_up", "move_down")
	
	# Prioritize horizontal movement over vertical
	if direction_horizontal != 0:
		animated_sprite_2d.play("walk_horizontal")
		animation_player.play("footstep")
		if direction_horizontal < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		velocity.x = direction_horizontal * SPEED
		velocity.y = 0  # Reset vertical movement when moving horizontally
	elif direction_vertical != 0:
		animation_player.play("footstep")
		if direction_vertical > 0:
			animated_sprite_2d.play("walk_down")
		else:
			animated_sprite_2d.play("walk_up")
		velocity.y = direction_vertical * SPEED
		velocity.x = 0  # Reset horizontal movement when moving vertically
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		animated_sprite_2d.play("idle")
	
	move_and_slide()
	
func play_footstep_audio():
	footstep_sound.pitch_scale = randf_range(.8, 1.2)
	footstep_sound.play()
